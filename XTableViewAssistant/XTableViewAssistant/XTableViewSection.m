//
//  XTableViewSection.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableViewSection.h"
#import "XTableViewRow.h"

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

- (NSArray<XTableViewRow *> *)rows
{
    return self.tableRows;
}

- (void)addRow:(XTableViewRow *)row
{
    [self.tableRows addObject:row];
}

@end
