//
//  XTableViewRow.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "XTableAction.h"
#import "XTableValidatorProtocol.h"

@class XTableViewSection;
@class XTableValidatorStatus;
@class XTableValidator;
@protocol XTableValidatorProtocol;

@interface XTableViewRow : NSObject

@property (nonatomic,weak)XTableViewSection *section;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *tag;
@property (nonatomic,assign) BOOL required;
@property (nonatomic,strong) id value;

@property (nonatomic,assign)CGFloat rowHeight;

@property (assign, readwrite, nonatomic) UITableViewCellSelectionStyle selectionStyle;

@property (nonatomic,strong)XTableAction *action;

@property (nonatomic,copy)NSString *cellIdentifier;

@property (nonatomic,copy) void (^selectedHandler)(XTableViewRow *tableViewRow);

+ (instancetype)row;
+ (instancetype)rowWithTitle:(NSString *)title;
+ (instancetype)rowWithTitle:(NSString *)title selectionHandler:(void (^)(XTableViewRow *row))selectionHandler;

- (instancetype)initWithTitle:(NSString *)title;
- (instancetype)initWithTitle:(NSString *)title selectionHandler:(void(^)(XTableViewRow *row))selectionHandler;

- (void)addValidator:(id<XTableValidatorProtocol>)validator;
- (void)removeValidator:(id <XTableValidatorProtocol>)validator;
- (XTableValidatorStatus *)doValidator;

- (void)deselectRowAnimated:(BOOL)animated;
- (void)deleteRowWithAnimated:(UITableViewRowAnimation)animated;

- (UIStoryboard *)uiStoryBoard;
- (NSIndexPath *)indexPath;



@end
