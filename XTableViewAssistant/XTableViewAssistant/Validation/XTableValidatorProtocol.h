//
//  XTableValidatorProtocol.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 22/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import <Foundation/Foundation.h>

@class XTableValidatorStatus;
@class XTableViewRow;

@protocol XTableValidatorProtocol

@required
- (XTableValidatorStatus *)valid:(XTableViewRow *)row;

@end

