//
//  XInputCell.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 22/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XInputCell.h"
#import "XInputRow.h"

@interface XInputCell()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation XInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)cellDidLoad
{
    self.inputField.delegate = self;
    
    [super cellDidLoad];
}

- (void)cellWillAppear
{
    [super cellWillAppear];

    XInputRow *row = (XInputRow *)self.rowDescription;
    if (row.title) {
        self.titleLabel.text = row.title;
    }
    
    if (row.value) {
        self.inputField.text = row.value;
    }
    
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
    self.titleLabel.text = nil;
    self.inputField.text = nil;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text) {
        self.rowDescription.value = textField.text;
    }
}

@end
