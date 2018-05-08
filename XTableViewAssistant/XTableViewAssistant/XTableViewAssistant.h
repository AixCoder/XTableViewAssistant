//
//  XTableViewAssistant.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XTableViewSection.h"
#import "XTableViewRow.h"


@interface XTableViewAssistant : NSObject

@property (nonatomic,readonly)NSArray <XTableViewSection *>*sections;
@property (nonatomic,readonly)NSArray *rows;

@property (nonatomic,weak) UITableView *tableView;

- (instancetype)initWithTableView:(UITableView *)table_view;

- (void)registerRowClass:(NSString *)rowClass forCellClass:(NSString*)cellClass;

- (void)addSection:(XTableViewSection *)section;

@end