//
//  InputViewController.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 22/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "InputViewController.h"
#import "XTableViewAssistant.h"

#import "XInputRow.h"
#import "XInputCell.h"
#import "XTableValidatorStatus.h"

@interface InputViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)XTableViewAssistant *tableAssistant;
@property (nonatomic,strong)XTableViewSection *section;

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _tableAssistant = [[XTableViewAssistant alloc] initWithTableView:self.tableView fromUIViewController:self];
    [_tableAssistant registerRowClass:NSStringFromClass([XInputRow class]) forCellClass:NSStringFromClass([XInputCell class])];
    
    _section = [XTableViewSection section];
    
    XInputRow *row = [XInputRow rowWithTitle:@"艺术家"];
    row.required = YES;
    [_section addRow:row];
    
    XInputRow *row1 = [XInputRow rowWithTitle:@"爱好"];
    row1.required = YES;
    [_section addRow:row1];
    [_tableAssistant addSection:_section];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnPressed:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)saveBtnPressed:(UIBarButtonItem *)button
{
    [self.tableView endEditing:YES];
    
    NSArray *errors = self.tableAssistant.validationErrors;
    
    if (errors.count >= 1) {
        //打印错误结果
        NSMutableString *errorStr = [NSMutableString string];
        for (XTableValidatorStatus *status in errors) {
            if (!status.isValid) {
                [errorStr appendString:status.statusMsg];
                [errorStr appendString:@"\n"];
            }
        }
        
        UIAlertController *alertCrtl = [UIAlertController alertControllerWithTitle:@"错误" message:errorStr preferredStyle:UIAlertControllerStyleAlert];
        [alertCrtl addAction:[UIAlertAction actionWithTitle:@"ok" style:UIAlertActionStyleDefault handler:NULL]];
        [self presentViewController:alertCrtl animated:YES completion:NULL];
        
    }else{
        
        NSMutableString *message = [NSMutableString string];
        for (XTableViewRow *row in self.section.rows) {
            [message appendString:[NSString stringWithFormat:@"%@ == %@",row.title,row.value]];
        }
        UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"保存成功" message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertCtrl addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL]];
        [self presentViewController:alertCtrl animated:YES completion:NULL];
    }
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
