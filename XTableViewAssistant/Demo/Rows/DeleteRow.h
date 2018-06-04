//
//  DeleteRow.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 04/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableViewRow.h"

@class DeleteRow;

@interface DeleteRow : XTableViewRow

@property (nonatomic,copy) void (^deleteHandler)(DeleteRow *tableViewRow);

@end
