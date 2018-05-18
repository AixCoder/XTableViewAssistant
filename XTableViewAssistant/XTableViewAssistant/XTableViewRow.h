//
//  XTableViewRow.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XTableAction.h"

@interface XTableViewRow : NSObject

@property (nonatomic,strong)XTableAction *action;
@property (nonatomic,copy) void (^selectedHandler)(id tableViewRow);

@property (nonatomic,copy)NSString *cellIdentifier;

@property (nonatomic,strong) id value;



- (UIStoryboard *)uiStoryBoard;

@end
