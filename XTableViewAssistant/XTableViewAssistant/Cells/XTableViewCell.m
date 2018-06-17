//
//  XTableViewCell.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XTableViewCell.h"
#import "XTableViewRow.h"
#import "XTableAction.h"

@interface XTableViewCell()

@property (nonatomic,assign)BOOL load;

@end

@implementation XTableViewCell

+ (CGFloat)cellHeightForRow:(XTableViewRow *)row tableViewAssistant:(XTableViewAssistant *)tableViewAssistant
{
    return row.rowHeight > 0 ? row.rowHeight : 0;
}

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

#pragma mark XTableViewCellProtocol

- (BOOL)xTableViewCellBecomeFirstResponder
{
    return [self becomeFirstResponder];
}

- (void)xTableViewCellDidSelectedFromViewController:(UIViewController *)controller
{
    //页面跳转处理
      XTableAction *action = self.rowDescription.action;
    if (action.storyBoardID && self.rowDescription.uiStoryBoard) {
        UIStoryboard *storyBoard = [self.rowDescription uiStoryBoard];
        UIViewController *nextController = [storyBoard instantiateViewControllerWithIdentifier:action.storyBoardID];
        if (controller.navigationController) {
            [controller.navigationController pushViewController:nextController animated:YES];
        }else{
            [controller presentViewController:nextController animated:YES completion:NULL];
        }
    }
    
}

@end
