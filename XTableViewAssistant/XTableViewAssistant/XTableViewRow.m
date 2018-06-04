//
//  XTableViewRow.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableViewRow.h"
#import "XTableValidatorStatus.h"
#import "XTableViewSection.h"
#import "XTableViewAssistant.h"

@interface XTableViewRow()

@property (nonatomic,strong)NSMutableArray *validators;

@end

@implementation XTableViewRow

#pragma mark init

- (instancetype)init
{
    self = [super init];
    if (self) {
        _validators = [NSMutableArray array];
    }
    return self;
}


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

- (instancetype)initWithTitle:(NSString *)title
{
    self = [self init];
    
    if (!self) {
        return nil;
    }
    _title = title;
    _selectedHandler = nil;
    return self;
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


#pragma mark validator

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

#pragma mark Manipulating row

- (void)deselectRowAnimated:(BOOL)animated
{
    [self.section.tableViewAssistant.tableView deselectRowAtIndexPath:self.indexPath animated:animated];
}

- (void)deleteRowWithAnimated:(UITableViewRowAnimation)animated
{
    NSIndexPath *rowPath = self.indexPath;
    NSUInteger row = rowPath.row;
    NSUInteger section = rowPath.section;
    
    if (row != NSNotFound && section != NSNotFound) {
        
        [self.section removeRow:self];
        NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:section];
        
        //table view delete row
        [self.section.tableViewAssistant.tableView beginUpdates];
        [self.section.tableViewAssistant.tableView deleteRowsAtIndexPaths:@[path] withRowAnimation:animated];
        [self.section.tableViewAssistant.tableView endUpdates];
    }
}

#pragma mark getter

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

- (NSIndexPath *)indexPath
{
    NSUInteger row = [self.section.rows indexOfObject:self];
    NSUInteger section = self.section.index;
    
    return  [NSIndexPath indexPathForRow:row inSection:section];
}

@end
