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

- (instancetype)initWithTableView:(UITableView *)table_view
{
    if (self = [super init]) {
        _tableSections = [NSMutableArray array];
        _registedXibs = [NSMutableDictionary dictionary];
        _registedCellClass = [NSMutableDictionary dictionary];
        
        NSAssert(table_view, @"table view is nill");
        table_view.delegate = self;
        table_view.dataSource = self;
        _tableView = table_view;
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            _tableView.rowHeight = UITableViewAutomaticDimension;
            _tableView.estimatedRowHeight = 44.;
            
        }
        
        
    }
    return self;
}

- (void)registerRowClass:(NSString *)rowClass forCellClass:(NSString*)cellClass
{
    Class row_class = NSClassFromString(rowClass);
    Class cell_class = NSClassFromString(cellClass);
    NSAssert([row_class isSubclassOfClass:[XTableViewRow class]], @"row class error");
    NSAssert([cell_class isSubclassOfClass:[UITableViewCell class]], @"cell class error");
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
    return self.tableSections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    XTableViewSection *section = self.tableSections[indexPath.section];
    XTableViewRow *row = section.rows[indexPath.row];
    
    Class cellClass = [self cellClassForRow:row];
    NSString *cellIdentifier;
    if (self.registedXibs[NSStringFromClass(row.class)]) {
        cellIdentifier= self.registedXibs[NSStringFromClass(row.class)];
    }else if (row.cellIdentifier){
        cellIdentifier = row.cellIdentifier;
    }
    NSAssert(cellIdentifier, @"");
    NSLog(@"cell id %@",cellIdentifier);
    
    XTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.rowDescription = row;
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

@end
