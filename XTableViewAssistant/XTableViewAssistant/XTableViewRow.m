//
//  XTableViewRow.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableViewRow.h"

@implementation XTableViewRow

- (XTableAction *)action
{
    if (!_action) {
        _action = [[XTableAction alloc] init];
    }
    return _action;
}

- (UIStoryboard *)uiStoryBoard
{
    return nil;
}

@end
