//
//  XTableRegexValidator.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 17/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableRegexValidator.h"
#import "XTableViewRow.h"

@implementation XTableRegexValidator

- (instancetype)initWithRemindMsg:(NSString *)msg regex:(NSString *)regex
{
    if (self = [super init]) {
        _regex = regex;
        
        _remindMsg = msg;
    }
    return self;
}

- (XTableValidatorStatus *)valid:(XTableViewRow *)row
{
    NSString *inputValue;
    if ([row.value isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber*)row.value;
        inputValue = number.stringValue;
    }else if ([row.value isKindOfClass:[NSString class]]){
        inputValue = (NSString*)row.value;
    }
    
    if (row.required == YES) {
        
        if (inputValue.length > 0) {
            //验证
            BOOL isValid = [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", self.regex] evaluateWithObject:[inputValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
            return [[XTableValidatorStatus alloc] initWithMsg:self.remindMsg isValid:isValid rowDescriptor:row];
            
        }else{
            
            NSString *resultStr = [NSString stringWithFormat:@"%@ 必须填写",row.title];
            return [[XTableValidatorStatus alloc] initWithMsg:resultStr isValid:NO rowDescriptor:row];
        }
    }
    
    return nil;
}

+ (instancetype)emailValidator
{
    return [[self alloc] initWithRemindMsg:@"输入有效的邮箱" regex:@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"];
}

@end
