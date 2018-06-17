//
//  XInputTextCell.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 09/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XInputTextCell.h"
#import "XInputTextRow.h"

@interface XInputTextCell()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputField;
@end

@implementation XInputTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.text = nil;
    self.inputField.text = nil;
    self.inputField.delegate = self;
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    XInputTextRow *row = (XInputTextRow*)self.rowDescription;
    self.inputField.placeholder = row.placeHolder;
    if (row.value) {
        self.inputField.text = row.value;
    }
    self.titleLabel.text = row.title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    XInputTextRow *row = (XInputTextRow *)self.rowDescription;
    //判断字符串是不是空，暂时用length属性判断，其实这样并不严禁
    if (textField.text.length > 0) {
        row.value = textField.text;
    }
    if (row.endEditingHandler) {
        row.endEditingHandler(row);
    }
    
}

@end
