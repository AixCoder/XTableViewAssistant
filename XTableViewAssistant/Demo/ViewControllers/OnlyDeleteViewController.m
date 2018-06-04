//
//  OnlyDeleteViewController.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 04/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "OnlyDeleteViewController.h"
#import "XTableViewAssistant.h"
#import "DeleteRow.h"
#import "DeleteTableViewCell.h"

@interface OnlyDeleteViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)XTableViewAssistant *tableAssistant;
@property (nonatomic,strong)XTableViewSection *section;

@end

@implementation OnlyDeleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableAssistant = [[XTableViewAssistant alloc] initWithTableView:self.tableView fromUIViewController:self];
    [self.tableAssistant registerRowClass:NSStringFromClass([DeleteRow class]) forCellClass:NSStringFromClass([DeleteTableViewCell class])];
    
    self.section = [XTableViewSection section];
    DeleteRow *row1 = [[DeleteRow alloc] init];
    row1.deleteHandler = ^(DeleteRow *tableViewRow) {
        [tableViewRow deleteRowWithAnimated:UITableViewRowAnimationFade];
    };
    
    DeleteRow *row2 = [[DeleteRow alloc] init];
    row2.deleteHandler = ^(DeleteRow *tableViewRow) {
        [tableViewRow deleteRowWithAnimated:UITableViewRowAnimationTop];
    };
    
    [self.section addRow:row1];
    [self.section addRow:row2];
    [self.tableAssistant addSection:self.section];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
