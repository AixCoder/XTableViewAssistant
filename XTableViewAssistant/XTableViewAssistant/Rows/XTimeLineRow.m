//
//  XTimeLineRow.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTimeLineRow.h"

@implementation XTimeLineRow

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UIStoryboard *)uiStoryBoard
{
    return [UIStoryboard storyboardWithName:@"Main" bundle:nil];
}

@end
