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
#import "XTableRegexValidator.h"

@interface InputViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)XTableViewAssistant *tableAssistant;

@end

@implementation InputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _tableAssistant = [[XTableViewAssistant alloc] initWithTableView:self.tableView fromUIViewController:self];
    _tableAssistant[@"XInputTextRow"] = @"XInputTextCell";//register cell
    
    //名字
    XTableViewSection *section0 = [[XTableViewSection alloc] initWithHeadTitle:@"取一个你喜欢的名字吧"];
    XInputTextRow *row;
    row = [XInputTextRow rowWithTitle:@"用户名" value:@"" placeholder:@"输入一个名字"];
    row.required = YES;
    [section0 addRow:row];
    
    //邮箱
    XTableViewSection *section1 = [[XTableViewSection alloc] initWithHeadTitle:@"真实的邮箱"];
    row = [XInputTextRow rowWithTitle:@"邮箱" value:nil placeholder:@"你常用的邮箱"];
    row.required = YES;
    [row addValidator:[XTableRegexValidator emailValidator]];
    [section1 addRow:row];
    
    //密码
    XTableViewSection *section2 = [[XTableViewSection alloc] initWithHeadTitle:@"设置你的密码" footerTitle:@"密码的长度在6-12位"];
    row = [XInputTextRow rowWithTitle:@"密码" value:nil placeholder:@"必填"];
    row.required = YES;
    [row addValidator: [[XTableRegexValidator alloc] initWithRemindMsg:@"密码长度不能少于6位，不能超过12位" regex:@"^(?=.*[A-Za-z]).{6,12}$"]];
    [section2 addRow:row];
    
    //附加项目
    XTableViewSection *section3 = [[XTableViewSection alloc] initWithHeadTitle:@"附加项"];
    row = [XInputTextRow rowWithTitle:@"喜欢的电影" value:nil placeholder:@"电影名称"];
    [section3 addRow:row];

    row = [XInputTextRow rowWithTitle:@"喜欢的作家" value:nil placeholder:@"骚年，你喜欢哪位作家"];
    [section3 addRow:row];
    row = [XInputTextRow rowWithTitle:@"喜欢的音乐家" value:nil placeholder:@"喜欢哪位音乐家呢"];
    [section3 addRow:row];
    
    [_tableAssistant addSection:section0];
    [_tableAssistant addSection:section1];
    [_tableAssistant addSection:section2];
    [_tableAssistant addSection:section3];
    
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
        
        [self.tableAssistant.sections enumerateObjectsUsingBlock:^(XTableViewSection * _Nonnull section, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [section.rows enumerateObjectsUsingBlock:^(XTableViewRow * _Nonnull row, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [message appendString:[NSString stringWithFormat:@"%@ = %@\n",row.title,row.value]];

            }];
        }];

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
