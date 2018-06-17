//
//  XTableRegexValidator.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 17/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableValidator.h"
#import "XTableValidatorStatus.h"

@interface XTableRegexValidator : XTableValidator

@property (nonatomic,readonly) NSString *remindMsg;//提示信息
@property (nonatomic,readonly) NSString *regex;//验证规则

- (instancetype)initWithRemindMsg:(NSString *)msg regex:(NSString *)regex;

+ (instancetype)emailValidator;

@end
