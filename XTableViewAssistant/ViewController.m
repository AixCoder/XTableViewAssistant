//
//  ViewController.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 08/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "ViewController.h"
#import "XTableViewAssistant.h"
#import "XTimeLineRow.h"
#import "XTimeLineCell.h"
#import "TestListViewController.h"
#import "InputViewController.h"
#import "OnlyDeleteViewController.h"

@interface ViewController ()

@property (nonatomic,strong)XTableViewAssistant *tableViewAssistant;
@property (nonatomic,strong)XTableViewSection *section;
@property (nonatomic,strong) XTimeLineRow *row;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _tableViewAssistant = [[XTableViewAssistant alloc] initWithTableView:_tableview fromUIViewController:self];
    [_tableViewAssistant registerRowClass:NSStringFromClass([XTimeLineRow class]) forCellClass:NSStringFromClass([XTimeLineCell class])];
    
    _section = [XTableViewSection section];
    _row = [[XTimeLineRow alloc] init];
    _row.value = @"仿虾米首页";
    _row.action.storyBoardID = @"xiami";
    
    XTableViewRow *row1 = [[XTableViewRow alloc] init];
    row1.selectedHandler = ^(id tableViewRow) {
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *settingVC = [board instantiateViewControllerWithIdentifier:@"Setting"];
        [self.navigationController pushViewController:settingVC animated:YES];
    };
    row1.value = @"设置页面";
    
    XTableViewRow *row2 = [[XTableViewRow alloc] init];

    row2.selectedHandler = ^(XTableViewRow *tableViewRow) {
        TestListViewController *vc = [[TestListViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        [tableViewRow deselectRowAnimated:YES];
    };
    row2.value = @"自定义cell";
    
    XTableViewRow *row3 = [[XTableViewRow alloc] init];
    row3.value = @"text field";
    row3.selectedHandler = ^(id tableViewRow) {
        InputViewController *inputVC = [[InputViewController alloc] init];
        [self.navigationController pushViewController:inputVC animated:YES];
    };
    
    XTableViewRow *row4 = [[XTableViewRow alloc] init];
    row4.value = @"删除";
    row4.selectedHandler = ^(XTableViewRow *tableViewRow) {
        OnlyDeleteViewController *deleteVC = [[OnlyDeleteViewController alloc] init];
        [self.navigationController pushViewController:deleteVC animated:YES];
    };
    [_section addRow:row1];
    [_section addRow:_row];
    [_section addRow:row2];
    [_section addRow:row3];
    [_section addRow:row4];//删除
    [_tableViewAssistant addSection:_section];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
