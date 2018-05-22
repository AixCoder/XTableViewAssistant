//
//  XTableViewAssistant.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableViewAssistant.h"
#import "XTableViewRow.h"
#import "XTableViewSection.h"
#import "XTableViewCell.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface XTableViewAssistant()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)NSMutableArray <XTableViewSection *>* tableSections;

@property (nonatomic,strong)NSMutableDictionary *registedCellClass;
@property (nonatomic,strong)NSMutableDictionary *registedXibs;

@end

@implementation XTableViewAssistant

#pragma mark init

- (instancetype)init
{
    @throw [NSException exceptionWithName:NSGenericException reason:@"please use initWithTableView" userInfo:nil];
    
    return nil;
}

- (instancetype)initWithTableView:(UITableView *)table_view fromUIViewController:(UIViewController *)viewController
{
    if (self = [super init]) {
        _tableSections = [NSMutableArray array];
        _registedXibs = [NSMutableDictionary dictionary];
        _registedCellClass = [NSMutableDictionary dictionary];
        
        NSAssert(table_view, @"table view is nill");
        NSAssert(viewController, @"view controller is nil");
        _viewController = viewController;
        table_view.delegate = self;
        table_view.dataSource = self;
        _tableView = table_view;
        [self registerDefaultCells];
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            _tableView.rowHeight = UITableViewAutomaticDimension;
            _tableView.estimatedRowHeight = 44.;
        }
        
    }
    return self;
}

- (void)registerDefaultCells
{
    [self registerRowClass:NSStringFromClass([XTableViewRow class]) forCellClass:NSStringFromClass([XTableViewCell class])];
}

- (void)registerRowClass:(NSString *)rowClass forCellClass:(NSString*)cellClass
{
    Class row_class = NSClassFromString(rowClass);
    Class cell_class = NSClassFromString(cellClass);
    NSAssert([row_class isSubclassOfClass:[XTableViewRow class]], @"row class error");
    NSAssert([cell_class isSubclassOfClass:[XTableViewCell class]], @"cell class error");
    
    self.registedCellClass[rowClass] = cell_class;
    
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *xibPath = [bundle pathForResource:cellClass ofType:@"nib"];
    if (xibPath) {
        self.registedXibs[rowClass] = cellClass;
        [self.tableView registerNib:[UINib nibWithNibName:cellClass bundle:bundle] forCellReuseIdentifier:cellClass];
    }
}

#pragma mark help

- (Class)cellClassForRow:(XTableViewRow*)row
{
    
    return self.registedCellClass[NSStringFromClass(row.class)];
}

- (void)addSection:(XTableViewSection *)section
{
    [self.tableSections addObject:section];
}

#pragma mark getter

- (NSArray<XTableViewSection *> *)sections
{
    return self.tableSections;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < self.tableSections.count) {
        XTableViewSection *tableSection = self.tableSections[section];
        return  tableSection.rows.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    XTableViewSection *section = self.tableSections[indexPath.section];
    XTableViewRow *row = section.rows[indexPath.row];
    
    Class cellClass = [self cellClassForRow:row];
    NSString *cellIdentifier = @"XTableViewCeMediall";
    if (self.registedXibs[NSStringFromClass(row.class)]) {
        cellIdentifier= self.registedXibs[NSStringFromClass(row.class)];
    }else if (row.cellIdentifier){
        cellIdentifier = row.cellIdentifier;
    }else{
        NSLog(@"没有设定cell重用标识符 ");
    }

    XTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell) {
        NSAssert([cell isKindOfClass:[XTableViewCell class]], @"cell 必须是XtableViewCell的子类");
    }
    
    void (^configurationCell)(XTableViewCell *cell) = ^(XTableViewCell *cell) {
        
        cell.tableViewAssistant = self;
        cell.rowDescription = row;
        cell.parentTableView = _tableView;
        
        [cell cellDidLoad];
    };
    
    if (cell == nil) {
        cell = [[cellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        configurationCell(cell);
    }
    if (cell && !cell.isLoaded) {
        configurationCell(cell);
    }
    
    [cell cellWillAppear];
    
    return cell;
    
}

#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //制定了高度就使用

    return self.tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //制定了高度就使用
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        return self.tableView.estimatedRowHeight;
    }
    
    return 44.;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XTableViewSection *section = self.sections[indexPath.section];
    XTableViewRow *row = section.rows[indexPath.row];
    
    if (row.selectedHandler) {
        row.selectedHandler(row);
    }else{
        
        XTableViewCell<XTableViewCellProtocol> *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        [cell xTableViewCellDidSelectedFromViewController:self.viewController];
    }
    
}


#pragma mark errors

- (NSArray *)validationErrors
{
    NSMutableArray *errors = [NSMutableArray array];
    
    for (XTableViewSection *section in self.sections) {
        
        for (XTableViewRow *row in section.rows) {
            XTableValidatorStatus *status = [row doValidator];
            if (status) {
                [errors addObject:status];
            }
        }
    }
    
    return errors;
}

@end
