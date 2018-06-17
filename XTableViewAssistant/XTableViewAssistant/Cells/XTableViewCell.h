//
//  XTableViewCell.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTableViewRow;
@class XTableViewAssistant;

@protocol XTableViewCellProtocol

- (BOOL)xTableViewCellBecomeFirstResponder;
- (void)xTableViewCellDidSelectedFromViewController:(UIViewController *)controller;

@end

@interface XTableViewCell : UITableViewCell<XTableViewCellProtocol>

@property (nonatomic,weak)XTableViewRow *rowDescription;
@property (nonatomic,weak)XTableViewAssistant *tableViewAssistant;

@property (nonatomic,weak)UITableView *parentTableView;

@property (nonatomic,readonly)BOOL isLoaded;

- (void)cellDidLoad;
- (void)cellWillAppear;

+ (CGFloat)cellHeightForRow:(XTableViewRow *)row
         tableViewAssistant:(XTableViewAssistant *)tableViewAssistant;



@end
