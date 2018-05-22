//
//  XTableValidatorStatus.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 22/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableValidatorStatus.h"

@implementation XTableValidatorStatus

- (instancetype)initWithMsg:(NSString *)status_msg isValid:(BOOL)isValid rowDescriptor:(XTableViewRow *)row
{
    if (self = [super init]) {
        _statusMsg = status_msg;
        _rowDescriptor = row;
        _isValid = isValid;
    }
    return self;
}

@end
