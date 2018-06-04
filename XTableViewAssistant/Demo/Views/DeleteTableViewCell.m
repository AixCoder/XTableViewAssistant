//
//  DeleteTableViewCell.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 04/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "DeleteTableViewCell.h"
#import "DeleteRow.h"

@interface DeleteTableViewCell()

@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end

@implementation DeleteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (IBAction)deleteButtonTapped:(id)sender {
    DeleteRow *row = (DeleteRow *)self.rowDescription;
    if (row.deleteHandler) {
        row.deleteHandler(row);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
