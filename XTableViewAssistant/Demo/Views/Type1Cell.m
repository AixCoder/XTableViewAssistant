//
//  Type1Cell.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 17/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "Type1Cell.h"
#import "Type1Row.h"

@implementation Type1Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)titleButtonTapped:(UIButton *)sender {
    Type1Row *row = (Type1Row *)self.rowDescription;
    if (row.didSeletedTitle) {
        row.didSeletedTitle(sender.titleLabel.text);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
