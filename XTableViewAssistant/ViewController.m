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
    _tableViewAssistant = [[XTableViewAssistant alloc] initWithTableView:_tableview];
    [_tableViewAssistant registerRowClass:NSStringFromClass([XTimeLineRow class]) forCellClass:NSStringFromClass([XTimeLineCell class])];
    
    _section = [XTableViewSection section];
    _row = [[XTimeLineRow alloc] init];
    _row.value = @"i am  super hero \n \n";
    
    [_section addRow:_row];
    [_tableViewAssistant addSection:_section];
    
//    [self.tableview reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
