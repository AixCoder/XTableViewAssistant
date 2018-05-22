//
//  XTableValidatorStatus.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 22/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class XTableViewRow;

@interface XTableValidatorStatus : NSObject

@property (nonatomic,weak)XTableViewRow *rowDescriptor;
@property (nonatomic,readonly)BOOL isValid;
@property (nonatomic,readonly)NSString *statusMsg;

- (instancetype)initWithMsg:(NSString *)status_msg isValid:(BOOL)isValid rowDescriptor:(XTableViewRow *)row;

@end
