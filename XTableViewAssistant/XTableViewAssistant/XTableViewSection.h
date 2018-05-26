//
//  XTableViewSection.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>


@class XTableViewRow;
@class XTableViewAssistant;

@interface XTableViewSection : NSObject

@property (nonatomic,readonly)NSArray<XTableViewRow *> *rows;
@property (nonatomic,weak) XTableViewAssistant *tableViewAssistant;

+ (instancetype)section;

- (void)addRow:(XTableViewRow *)row;

- (NSUInteger)index;

@end
