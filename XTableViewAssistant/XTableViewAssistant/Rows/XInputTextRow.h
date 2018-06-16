//
//  XInputTextRow.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 09/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableViewRow.h"

@interface XInputTextRow : XTableViewRow

@property (nonatomic,readonly,copy)NSString *placeHolder;
@property (copy,nonatomic) void (^endEditingHandler)(XInputTextRow *textRow);


+ (instancetype)rowWithTitle:(NSString *)title
                       value:(NSString*)inputValue
                 placeholder:(NSString *)placeholder;


@end
