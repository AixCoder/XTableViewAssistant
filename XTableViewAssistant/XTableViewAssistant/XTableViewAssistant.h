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

@protocol XTableViewAssistantDelegate<UITableViewDelegate>

@end


@interface XTableViewAssistant : NSObject

@property (nonatomic,readonly)NSArray <XTableViewSection *> *sections;

@property (nonatomic,weak) id<XTableViewAssistantDelegate>delegate;

@property (nonatomic,readonly)NSArray *validationErrors;

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIViewController *viewController;

- (instancetype)initWithTableView:(UITableView *)table_view fromUIViewController:(UIViewController *)viewController;
- (instancetype)initWithTableView:(UITableView *)tableView fromUIViewController:(UIViewController *)viewController tableViewAssistantDelegate:(id<XTableViewAssistantDelegate>) assistantDelegate;

- (id)objectAtKeyedSubscript:(id <NSCopying>)key;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;


- (void)registerRowClass:(NSString *)rowClass forCellClass:(NSString*)cellClass;

- (void)addSection:(XTableViewSection *)section;


@end
