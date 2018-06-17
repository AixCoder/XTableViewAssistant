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
    self = [self initWithTableView:table_view
              fromUIViewController:viewController
        tableViewAssistantDelegate:nil];
    if (self) {
        return self;
    }else return nil;
}

- (instancetype)initWithTableView:(UITableView *)tableView fromUIViewController:(UIViewController *)viewController tableViewAssistantDelegate:(id<XTableViewAssistantDelegate>)assistantDelegate
{
    if (self = [super init]) {
        _tableSections = [NSMutableArray array];
        _registedXibs = [NSMutableDictionary dictionary];
        _registedCellClass = [NSMutableDictionary dictionary];
        
        NSAssert(tableView, @"table view is nill");
        NSAssert(viewController, @"view controller is nil");
        tableView.dataSource = self;
        tableView.delegate = self;
        _tableView = tableView;
        
        _viewController = viewController;
        [self registerDefaultCells];
        
        if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
            _tableView.rowHeight = UITableViewAutomaticDimension;
            _tableView.estimatedRowHeight = 44.;
        }
        self.delegate = assistantDelegate ? assistantDelegate : nil;
        return self;
    }
    return nil;
}

- (void)registerDefaultCells
{
    [self registerRowClass:NSStringFromClass([XTableViewRow class]) forCellClass:NSStringFromClass([XTableViewCell class])];
}

- (void)registerRowClass:(NSString *)rowClass forCellClass:(NSString*)cellClass
{
    [self registerRowClass:rowClass forCellClass:cellClass bundle:[NSBundle mainBundle]];
}

- (void)registerRowClass:(NSString *)rowClass forCellClass:(NSString *)cellClass bundle:(NSBundle *)bundle
{
    Class row_class = NSClassFromString(rowClass);
    Class cell_class = NSClassFromString(cellClass);
    
    NSAssert([row_class isSubclassOfClass:[XTableViewRow class]], @"row class error");
    NSAssert([cell_class isSubclassOfClass:[XTableViewCell class]], @"cell class error");
    
    self.registedCellClass[rowClass] = cell_class;
    if (!bundle) {
        bundle = [NSBundle mainBundle];
    }
    NSString *xibPath = [bundle pathForResource:cellClass ofType:@"nib"];
    if (xibPath) {
        self.registedXibs[rowClass] = cellClass;
        [self.tableView registerNib:[UINib nibWithNibName:cellClass bundle:bundle] forCellReuseIdentifier:cellClass];
    }
}

- (void)setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key
{
    [self registerRowClass:(NSString*)key forCellClass:obj];
}

- (id)objectAtKeyedSubscript:(id<NSCopying>)key
{
    return self.registedCellClass[key];
}

#pragma mark help

- (Class)cellClassForRow:(XTableViewRow*)row
{
    
    return self.registedCellClass[NSStringFromClass(row.class)];
}

- (void)addSection:(XTableViewSection *)section
{
    if ([section isKindOfClass:[XTableViewSection class]]) {
        section.tableViewAssistant = self;
    }
    
    [self.tableSections addObject:section];
}

#pragma mark getter

- (NSArray<XTableViewSection *> *)sections
{
    return self.tableSections;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sections.count;
}

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
    NSString *cellIdentifier;
    if (self.registedXibs[NSStringFromClass(row.class)]) {
        cellIdentifier= self.registedXibs[NSStringFromClass(row.class)];
    }else if (row.cellIdentifier){
        cellIdentifier = row.cellIdentifier;
    }else{
        cellIdentifier = NSStringFromClass(row.class);
    }

    NSAssert(cellIdentifier, @"table view 必须register cell");
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    XTableViewSection *section = self.sections[indexPath.section];
    XTableViewRow *row = section.rows[indexPath.row];
    
    if (row.selectedHandler) {
        row.selectedHandler(row);
    }
    else
    {
        XTableViewCell<XTableViewCellProtocol> *cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell xTableViewCellDidSelectedFromViewController:self.viewController];
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section < self.sections.count) {
        
        if ([self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
            return [self.delegate tableView:tableView viewForHeaderInSection:section];
        }
        XTableViewSection *tableViewSection = self.sections[section];
        return tableViewSection.headerView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section < self.sections.count) {
        
        XTableViewSection *tableViewSection = self.sections[section];
        if ([self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
            return [self.delegate tableView:tableView viewForFooterInSection:section];
        }
        
        return tableViewSection.footerView;
        
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section < self.sections.count) {
        XTableViewSection *tableViewSection = self.sections[section];
        return tableViewSection.footerTitle;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section < self.sections.count) {
        XTableViewSection *tableViewSection = self.sections[section];
        return tableViewSection.headTitle;
    }
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //制定了高度就使用
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //制定了高度就使用
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0")) {
        return self.tableView.estimatedRowHeight;
    }
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (self.sections.count <= section) {
        return 0;
    }
    
    XTableViewSection *table_section = self.sections[section];
    if (table_section.headerView) {
        return table_section.headerView.frame.size.height;
    }else if (table_section.headTitle){
        
        CGFloat width = CGRectGetWidth(tableView.bounds) - 20;
        CGFloat height = MAXFLOAT;
        CGSize headerSize = CGSizeMake(width, height);
        CGRect headerFrame = [table_section.headTitle boundingRectWithSize:headerSize
                                                               options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                            attributes:@{ NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline] }
                                                               context:nil];
        
        return headerFrame.size.height;
    }
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)sectionIndex
{
    if (self.sections.count <= sectionIndex) {
        return 0;
    }
    
    XTableViewSection *section = self.sections[sectionIndex];
    if (section.footerView) {
        return CGRectGetHeight(section.footerView.bounds);
    }else if (section.footerTitle){
        
        CGFloat width = CGRectGetWidth(tableView.bounds) - 20;
        CGFloat height = MAXFLOAT;
        CGSize headerSize = CGSizeMake(width, height);
        CGRect headerFrame = [section.footerTitle boundingRectWithSize:headerSize
                                                             options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                          attributes:@{ NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline] }
                                                             context:nil];
        
        return headerFrame.size.height;
    }
    return UITableViewAutomaticDimension;
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
