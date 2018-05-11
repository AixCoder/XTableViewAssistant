//
//  XTableViewCell.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableViewCell.h"

@interface XTableViewCell()

@property (nonatomic,assign)BOOL load;

@end

@implementation XTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (BOOL)isLoaded
{
    return self.load;
}

- (void)cellDidLoad
{
    self.load = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWillAppear
{
    
}

@end
