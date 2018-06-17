//
//  Type2Cell.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 17/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "Type2Cell.h"
#import "Type1Row.h"

@interface Type2Cell()
@property (weak, nonatomic) IBOutlet UIImageView *bigPhotoView;

@end

@implementation Type2Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellWillAppear
{
    [super cellWillAppear];

    Type2Row *row = (Type2Row *)self.rowDescription;
    _bigPhotoView.image = row.bigPhoto;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
}



@end
