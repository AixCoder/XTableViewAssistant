//
//  XTableViewSection.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>


@class XTableViewRow;

@interface XTableViewSection : NSObject

@property (nonatomic,readonly)NSArray<XTableViewRow *> *rows;

+ (instancetype)section;

- (void)addRow:(XTableViewRow *)row;

@end
