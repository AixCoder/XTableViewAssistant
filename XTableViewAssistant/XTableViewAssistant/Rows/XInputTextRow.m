//
//  XInputTextRow.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 09/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XInputTextRow.h"

@implementation XInputTextRow


+ (instancetype)rowWithTitle:(NSString *)title
                       value:(NSString *)inputValue
                 placeholder:(NSString *)placeholder
{
    return [[self alloc] initWithTitle:title value:inputValue placeholder:placeholder];
}

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)inputValue placeholder:(NSString *)placeholder
{
    self = [super init];
    if (self) {
        self.title = title;
        self.value = inputValue;
        _placeHolder = placeholder;
    }
    return self;
}

@end
