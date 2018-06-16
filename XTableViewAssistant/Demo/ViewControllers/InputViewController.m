//
//  InputViewController.m
//  XTableViewAssistant
//
//  Created by liuhongnian on 22/05/2018.
//  Copyright © 2018 liuhongnian. All rights reserved.
//

#import "InputViewController.h"
#import "XTableViewAssistant.h"

#import "XInputTextRow.h"
#import "XInputTextCell.h"
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
    _tableAssistant[@"XInputTextRow"] = @"XInputTextCell";//register cell
    
    _section = [XTableViewSection section];
    XInputTextRow *row = [XInputTextRow rowWithTitle:@"电影" value:nil placeholder:@"请输入你喜欢的电影"];
    row.required = YES;
    row.endEditingHandler = ^(XInputTextRow *textRow) {
        NSString *name = textRow.value;
        NSLog(@"电影名字：%@",name);
    };
    
    XInputTextRow *row1 = [XInputTextRow rowWithTitle:@"导演" value:nil placeholder:@"请输入电影的导演"];
    row1.endEditingHandler = ^(XInputTextRow *textRow) {
        NSString *obj = textRow.value;
        NSLog(@"导演：%@",obj);
    };
    row1.required = YES;
    
    XInputTextRow *row2 = [XInputTextRow rowWithTitle:@"年份" value:@"2001" placeholder:@""];
    row2.endEditingHandler = ^(XInputTextRow *textRow) {
        NSLog(@"更改年份：%@",textRow.value);
    };
    [_section addRow:row];
    [_section addRow:row1];
    [_section addRow:row2];
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
