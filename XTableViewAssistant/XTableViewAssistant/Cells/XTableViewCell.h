//
//  XTableViewCell.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTableViewRow;

@interface XTableViewCell : UITableViewCell

@property (nonatomic,weak)XTableViewRow *rowDescription;

- (void)cellWillAppear;

@end
