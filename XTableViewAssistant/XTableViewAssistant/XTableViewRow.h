//
//  XTableViewRow.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XTableViewRow : NSObject

@property (nonatomic,copy)NSString *cellIdentifier;

@property (nonatomic,strong) id value;

@end
