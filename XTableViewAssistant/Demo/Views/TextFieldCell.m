//
//  TextFieldCell.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 16/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "TextFieldCell.h"
#import "TextFieldRow.h"

@interface TextFieldCell()


@property (weak, nonatomic) IBOutlet UITextField *myTextField;

@end

@implementation TextFieldCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellDidLoad
{
    [super cellDidLoad];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    self.myTextField.text = self.rowDescription.value;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
