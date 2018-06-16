//
//  HeaderOrFooterViewController.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 16/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "HeaderOrFooterViewController.h"
#import "XTableViewAssistant.h"
#import "SongListRow.h"
#import "SongListCell.h"

@interface HeaderOrFooterViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (nonatomic,strong)XTableViewAssistant *tableAssistant;
@property (nonatomic,strong)XTableViewSection *section;

@end

@implementation HeaderOrFooterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableAssistant = [[XTableViewAssistant alloc] initWithTableView:self.tableView fromUIViewController:self];
    self.tableAssistant[@"SongListRow"] = @"SongListCell"; //register cell
    
    //add section with header view and footerView;
    _section = [[XTableViewSection alloc] initWithHeadView:_headerView footerView:_footerView];
 
    SongListRow *row = [[SongListRow alloc] init];
    [_section addRow:row];
    
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
