//
//  XTimeLineCell.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTimeLineCell.h"
#import "XTimeLineRow.h"


@implementation XTimeLineCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    NSLog(@"%@",self.rowDescription);
    XTimeLineRow *rowDes = (XTimeLineRow*)self.rowDescription;
    self.titleLabel.text = rowDes.value;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
