//
//  XTableViewSection.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableViewSection.h"
#import "XTableViewRow.h"
#import "XTableViewAssistant.h"

@interface XTableViewSection()

@property (nonatomic,strong)NSMutableArray<XTableViewRow *> *tableRows;

@end

@implementation XTableViewSection

+ (instancetype)section
{
    return [[self alloc] init];
}

- (instancetype)init
{
    if (self = [super init]) {
        _tableRows = [NSMutableArray array];
    }
    return self;
}

- (instancetype)initWithHeadTitle:(NSString *)headTitle
{
    return [self initWithHeadTitle:headTitle footerTitle:nil];
}

- (instancetype)initWithHeadTitle:(NSString *)headTitle footerTitle:(NSString *)footerTitle
{
    if (self = [self init]) {
        _headTitle = headTitle;
        _footerTitle = footerTitle;
    }
    return self;
}

- (instancetype)initWithHeadView:(UIView *)headView
{
    return [self initWithHeadView:headView footerView:nil];
}

- (instancetype)initWithHeadView:(UIView *)headView footerView:(UIView *)footerView
{
    if (self = [self init]) {
        _headerView = headView;
        _footerView = footerView;
    }
    
    return self;
}

- (NSArray<XTableViewRow *> *)rows
{
    return self.tableRows;
}

- (void)addRow:(XTableViewRow *)row
{
    if ([row isKindOfClass:[XTableViewRow class]]) {
        row.section = self;
    }
    [self.tableRows addObject:row];
}

- (void)removeRow:(XTableViewRow *)row
{
    if ([self.tableRows containsObject:row]) {
        [self.tableRows removeObject:row];
    }
}

#pragma mark getter

- (NSUInteger)index
{
    return  [self.tableViewAssistant.sections indexOfObject:self];
}

@end
