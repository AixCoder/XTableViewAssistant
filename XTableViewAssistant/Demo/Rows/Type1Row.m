//
//  Type1Row.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 17/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "Type1Row.h"

@implementation Type1Row

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

@implementation Type2Row

- (instancetype)initWithBigPhoto:(UIImage *)photo
{
    if (self = [super init]) {
        _bigPhoto = photo;
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

@end

@implementation Type3Row


- (instancetype)initWithContent:(NSDictionary *)rowContent
{
    if (self = [super init]) {
        self.value = rowContent;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}
@end
