//
//  Type3Cell.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 17/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "Type3Cell.h"
#import "Type1Row.h"

@interface Type3Cell()
@property (weak, nonatomic) IBOutlet UIImageView *portraitView;

@property (weak, nonatomic) IBOutlet UIImageView *picView;
@property (weak, nonatomic) IBOutlet UILabel *imageTitle;
@property (weak, nonatomic) IBOutlet UILabel *imageDes;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation Type3Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _typeLabel.layer.borderColor = [[UIColor blackColor] CGColor];
    _typeLabel.layer.borderWidth = 1;
}

- (void)cellWillAppear
{
    [super cellWillAppear];

    Type3Row *row = (Type3Row*)self.rowDescription;
    
    NSDictionary *content = row.value;
    NSString *imgTitle = content[@"imageTitle"];
    NSString *imgDes = content[@"imageDescription"];
    NSString *type = content[@"type"];
    UIImage *image = content[@"contentImage"];
    UIImage *portraitImage = content[@"portrait"];
    _portraitView.image = portraitImage;
    _picView.image = image;
    _imageTitle.text = imgTitle;
    _imageDes.text = imgDes;
    _typeLabel.text = type;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
