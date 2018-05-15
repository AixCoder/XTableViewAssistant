//
//  XiaMiViewController.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 09/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "XiaMiViewController.h"

#import "XTableViewAssistant.h"
#import "ChannelRow.h"
#import "ChannelCell.h"
#import "SongListRow.h"
#import "SongListCell.h"

@interface XiaMiViewController ()

@property (nonatomic,strong)XTableViewAssistant *tableViewAssistant;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XiaMiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadTableView];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadTableView
{
    _tableViewAssistant = [[XTableViewAssistant alloc] initWithTableView:self.tableView fromUIViewController:self];
    [_tableViewAssistant registerRowClass:NSStringFromClass([ChannelRow class]) forCellClass:NSStringFromClass([ChannelCell class])];
    [_tableViewAssistant registerRowClass:NSStringFromClass([SongListRow class]) forCellClass:NSStringFromClass([SongListCell class])];
    
    XTableViewSection *section = [XTableViewSection section];
    ChannelRow *row = [[ChannelRow alloc] init];
    [section addRow:row];
    
    SongListRow *songListRow1 = [[SongListRow alloc] init];
    [section addRow:songListRow1];
    [_tableViewAssistant addSection:section];
    
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
