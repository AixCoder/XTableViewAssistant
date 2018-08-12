//
//  RowTypesViewController.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 17/06/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "RowTypesViewController.h"
#import "Type1Row.h"
#import "Type1Cell.h"
#import "Type2Cell.h"
#import "Type3Cell.h"
#import "XTableViewAssistant.h"

@interface RowTypesViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) XTableViewAssistant *tableViewAssistant;
@property (nonatomic,strong) XTableViewSection *section;

@end

@implementation RowTypesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadTableView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"插入" style:UIBarButtonItemStylePlain target:self action:@selector(reloadTableView)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)loadTableView
{
    _tableViewAssistant = [[XTableViewAssistant alloc] initWithTableView:self.tableView fromUIViewController:self];
    _tableViewAssistant[@"Type1Row"] = @"Type1Cell";
    _tableViewAssistant[@"Type2Row"] = @"Type2Cell";
    _tableViewAssistant[@"Type3Row"] = @"Type3Cell";

    _section = [XTableViewSection section];
    Type1Row *row1 = [[Type1Row alloc] init];
    row1.rowHeight = 60;
    
    Type2Row *row2 = [[Type2Row alloc] initWithBigPhoto:[UIImage imageNamed:@"big_photo"]];
    
    NSDictionary *dic = @{@"imageTitle":@"视觉盛宴，第四届FAPA艺术摄影奖揭晓视觉盛宴.",
                          @"imageDescription":@"一群富有激情的摄影师",
                          @"type":@"摄影大作",
                          @"contentImage":[UIImage imageNamed:@"photography"],
                          @"portrait":[UIImage imageNamed:@"portrait_logo"]
                          };
    Type3Row *row3 = [[Type3Row alloc] initWithContent:dic];
    row3.selectedHandler = ^(XTableViewRow *tableViewRow) {

    };
    
    [_tableViewAssistant addSection:_section];
    [_section addRow:row1];
    [_section addRow:row2];
    [_section addRow:row3];
    
}

- (void)reloadTableView
{

    Type1Row *row = [[Type1Row alloc] init];
    row.rowHeight = 80;
    
    [_section insertRow:row toIndex:_section.rows.count -1 animated:UITableViewRowAnimationBottom];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}



@end
