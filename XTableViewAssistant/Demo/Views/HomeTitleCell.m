//
//  HomeTitleCell.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 09/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "HomeTitleCell.h"
#import "HomeTitleRow.h"

@interface HomeTitleCell()

@property (weak, nonatomic) IBOutlet UILabel *homeTitle;
@end


@implementation HomeTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _homeTitle.text = nil;
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.homeTitle.text = self.rowDescription.value;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
