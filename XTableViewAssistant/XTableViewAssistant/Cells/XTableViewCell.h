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

@interface XTableViewCell : UITableViewCell

@property (nonatomic,weak)XTableViewRow *rowDescription;
@property (nonatomic,weak)XTableViewAssistant *tableViewAssistant;

@property (nonatomic,weak)UITableView *parentTableView;

@property (nonatomic,readonly)BOOL isLoaded;

- (void)cellDidLoad;
- (void)cellWillAppear;


@end
