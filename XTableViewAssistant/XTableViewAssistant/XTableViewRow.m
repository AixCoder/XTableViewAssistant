//
//  XTableViewRow.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableViewRow.h"
#import "XTableValidatorStatus.h"

@interface XTableViewRow()

@property (nonatomic,strong)NSMutableArray *validators;

@end

@implementation XTableViewRow

- (instancetype)init
{
    self = [super init];
    if (self) {
        _validators = [NSMutableArray array];
    }
    return self;
}

#pragma mark init

+ (instancetype)row
{
    return [[self alloc] init];
    
}

+ (instancetype)rowWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title selectionHandler:nil];
}

+ (instancetype)rowWithTitle:(NSString *)title selectionHandler:(void (^)(XTableViewRow *))selectionHandler
{
    return [[self alloc] initWithTitle:title selectionHandler:selectionHandler];
}


- (instancetype)initWithTitle:(NSString *)title selectionHandler:(void (^)(XTableViewRow *))selectionHandler
{
    self = [self init];
    if (!self) {
        return nil;
    }
    _title = title;
    _selectedHandler = selectionHandler;
    
    return self;
}



- (XTableAction *)action
{
    if (!_action) {
        _action = [[XTableAction alloc] init];
    }
    return _action;
}

- (UIStoryboard *)uiStoryBoard
{
    return nil;
}

- (void)addValidator:(id<XTableValidatorProtocol>)validator
{
    
    if (validator == nil) {
        return;
    }
    
    if (![self.validators containsObject:validator]) {
        [self.validators addObject:validator];
    }
    
}

- (void)removeValidator:(id<XTableValidatorProtocol>)validator
{
    if ([self.validators containsObject:validator]) {
        [self.validators removeObject:validator];
    }
}

- (XTableValidatorStatus *)doValidator
{
    //必填项验证
    XTableValidatorStatus *status;
    if (self.required) {
        BOOL isEmpty = [self valueIsEmpty];
        
        if (isEmpty) {
            NSString *msg;
            if (self.title) {
                msg = [NSString stringWithFormat:@"%@ 必填",self.title];
            }else if (self.tag){
                msg = [NSString stringWithFormat:@"%@ 必填",self.tag];
            }else{
                msg = @"";
            }
            
            status = [[XTableValidatorStatus alloc] initWithMsg:msg isValid:NO rowDescriptor:self];
            return status;
        }
    }
    
    
    //自定义验证规则
    for (id<XTableValidatorProtocol> validator in self.validators)
    {
        XTableValidatorStatus *vStatus = [validator valid:self];
        if (vStatus && !vStatus.isValid ) {
            return vStatus;
        }
        status = vStatus;
    }
    
    return status;
}

- (BOOL)valueIsEmpty
{
    return self.value == nil ||
    [self.value isKindOfClass:[NSNull class]] ||
    [self.value isEqualToString:@""];
}

@end
