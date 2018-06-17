//
//  Type1Row.h
//  XTableViewAssistant
//
//  Created by liuhongnian on 17/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableViewRow.h"

@interface Type1Row : XTableViewRow

@property (nonatomic,copy)void (^didSeletedTitle)(NSString *title);

@end

@interface Type2Row: XTableViewRow


@property (nonatomic,readonly)UIImage *bigPhoto;

@property (nonatomic,copy)void (^didSelectedTitle)(NSString *buttonTitle);
- (instancetype)initWithBigPhoto:(UIImage *)photo;

@end

@interface Type3Row : XTableViewRow

- (instancetype)initWithContent:(NSDictionary*)content;

@end
