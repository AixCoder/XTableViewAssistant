//
//  XTableViewSection.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>

@import UIKit;

@class XTableViewRow;
@class XTableViewAssistant;

@interface XTableViewSection : NSObject

@property (nonatomic,readonly)NSArray<XTableViewRow *> *rows;
@property (nonatomic,weak) XTableViewAssistant *tableViewAssistant;

@property (nonatomic,assign) CGFloat headerViewHeight;
@property (nonatomic,assign) CGFloat footerViewHeight;

@property (nonatomic,readonly) NSString *headTitle;
@property (nonatomic,readonly) NSString *footerTitle;

@property (nonatomic,readonly) UIView *headerView;
@property (nonatomic,readonly) UIView *footerView;

+ (instancetype)section;
- (instancetype)initWithHeadTitle:(NSString *)headTitle;
- (instancetype)initWithHeadTitle:(NSString *)headTitle
                      footerTitle:(NSString *)footerTitle;

- (instancetype)initWithHeadView:(UIView *)headView;
- (instancetype)initWithHeadView:(UIView *)headView
                      footerView:(UIView *)footerView;


- (void)addRow:(XTableViewRow *)row;
- (void)insertRow:(XTableViewRow *)row
          toIndex:(NSUInteger)index
         animated:(UITableViewRowAnimation )rowAnimation;
- (void)removeRow:(XTableViewRow *)row;
- (void)removeAllRows;

- (NSUInteger)index;

@end
