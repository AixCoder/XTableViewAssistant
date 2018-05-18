//
//  TestListViewController.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 18/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "TestListViewController.h"
#import "XTableViewAssistant.h"
#import "TestListRow.h"
#import "TestListCell.h"

@interface TestListViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) XTableViewAssistant *tableAssistant;

@end

@implementation TestListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableAssistant = [[XTableViewAssistant alloc] initWithTableView:_tableView fromUIViewController:self];
    [_tableAssistant registerRowClass:NSStringFromClass([TestListRow class]) forCellClass:NSStringFromClass([TestListCell class])];
    
    XTableViewSection *section = [XTableViewSection section];
    for (int i = 0; i < 20; ++i) {
        TestListRow *row = [[TestListRow alloc] init];
        [section addRow:row];
    }
    [_tableAssistant addSection:section];
    
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
