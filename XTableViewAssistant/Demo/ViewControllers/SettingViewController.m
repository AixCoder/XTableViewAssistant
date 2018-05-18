//
//  SettingViewController.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 16/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "SettingViewController.h"
#import "XTableViewAssistant.h"
#import "TextFieldRow.h"
#import "TextFieldCell.h"

@interface SettingViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) XTableViewSection *section;
@property (nonatomic,strong) XTableViewAssistant *tableAssistant;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initTableView
{
    _tableAssistant = [[XTableViewAssistant alloc] initWithTableView:self.tableView fromUIViewController:self];
    [_tableAssistant registerRowClass:NSStringFromClass([TextFieldRow class]) forCellClass:NSStringFromClass([TextFieldCell class])];
    
    TextFieldRow *row = [[TextFieldRow alloc] init];
    row.value = @"78";
    _section = [[XTableViewSection alloc] init];
    [_section addRow:row];
    
    [self.tableAssistant addSection:_section];
    
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
