# XTableViewAssistant
帮助你快速创建表单，提升开发效率


# UITableView代码整洁之道0
![网络图片](http://odumnx077.bkt.clouddn.com/tcc1.png)
懒了很久（哈哈），博客一直没更新，最近在维护老项目，看人家的代码，修复人家的bug（添坑）。
在维护项目的过程中也发现了一些可以改进的地方，举个栗子-思考如何把UITableView的代码写的更为简洁。
UITableView作为每个iOS肯定都会接触到的控件，几乎每个app内都会出现，对于这种高频使用的控件，如何把相关的代码写的更为简洁，应该是每个iOSer的必修课。
<!--more-->

UITableView的常规写法
举个栗子----要实现如下图的需求
![](http://odumnx077.bkt.clouddn.com/tcc2.png)
图中的tableview需要展示3个cell，刚开始学习的时候都是这样写的
```objective-c
//初始化tableview后注册cell
    [self.tableView registerNib:@"nib文件名" forCellReuseIdentifier:@"cell_id"];
//接着实现tableview的代理
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
//        return topCell;
    }else if (indexPath.row == 1){
//        return secondCell;
        
    }else if (indexPath.row == 2){
//        return thirdCell;
    }
    
}
```
这样写很明显在cellForRowAtIndexPath方法中有着大量的if else，如果需要显示好多种类型的cell，那么大量的if else使得代码看起来不够简洁优雅。

那么有什么方法能把tableview的代码写的整洁些呢，老司机带路，教大家一个小技巧。

#优化UITableView代码
这里推荐一个自己封装的库[XTableViewAssistant](https://github.com/AixCoder/XTableViewAssistant)，以数据来驱动UITableView，使得tableview的代码简洁，帮助你快速创建UITableView，使用后如果有什么建议，欢迎提出。
更多用法参考github上的demo

我们接着来看下如何优化tableview的代码
![](http://odumnx077.bkt.clouddn.com/tcc3.png)
这个tableview包含一个section（黄色线条区域），section下包含三个cell

对照这个图来说明下XTableViewAssistant怎么使用
```objective-c
- (void)loadTableView
{

//1 首先实例化XTableViewAssistant,tableview的代理方法都交由XTableViewAssistant这个类来实现，就无需在view controller里实现代理方法，从而轻量化view controller
    _tableViewAssistant = [[XTableViewAssistant alloc] initWithTableView:self.tableView fromUIViewController:self];
    
    //2注册 cell，等同于 [self.tableView registerNib:@"nib文件名" forCellReuseIdentifier:@"cell_id"];
//Type1Row 继承与XTableViewRow，cell页面是由这些数据来驱动的，cell需要的数据都封装在XTableViewRow类中，这三行代码的意思：向tableview注册cell，告诉cell有其各自的模型数据

    _tableViewAssistant[@"Type1Row"] = @"Type1Cell";
    _tableViewAssistant[@"Type2Row"] = @"Type2Cell";
    _tableViewAssistant[@"Type3Row"] = @"Type3Cell";


    //3创建cell需要的模型，Type1Row包含了cell需要的数据
    //第一行cell的模型
    Type1Row *row1 = [[Type1Row alloc] init];
    row1.rowHeight = 60;
    //第二行cell的模型
    Type2Row *row2 = [[Type2Row alloc] initWithBigPhoto:[UIImage imageNamed:@"big_photo"]];
    
    NSDictionary *dic = @{@"imageTitle":@"视觉盛宴，第四届FAPA艺术摄影奖揭晓视觉盛宴.",
                          @"imageDescription":@"一群富有激情的摄影师",
                          @"type":@"摄影大作",
                          @"contentImage":[UIImage imageNamed:@"photography"],
                          @"portrait":[UIImage imageNamed:@"portrait_logo"]
                          };


//第三行cell的模型
    Type3Row *row3 = [[Type3Row alloc] initWithContent:dic];
    row3.selectedHandler = ^(XTableViewRow *tableViewRow) {

    };
    //4添加section
    _section = [XTableViewSection section];
    [_tableViewAssistant addSection:_section];
    //5 section下添加cell
    [_section addRow:row1];
    [_section addRow:row2];
    [_section addRow:row3];
    
    //table view reloadData
    
}
```

这样创建UITableView的时候就像堆积木一样，比较灵活，代码也不难理解 XTableViewSection类就是tableview对应的section的抽象，tableview有几个section，就添加几个XTableViewSection
    
cell所有的数据都存在XTableViewRow中，section里要展示多少行cell，就往section里添加多少个XTableViewRow,

整个库的核心代码是XTableViewAssistant，代码量都不大，更多用法参考[demo](https://github.com/AixCoder/XTableViewAssistant)

这样创建tableview的时候就不要每次都去写tableview的代理方法，cell也是由模型来驱动的，cell只管显示数据，处理用户交互事件，cell的数据则都交由XTableViewRow来处理。单一职责的思想帮助我们来让tableview的代码优雅点。

使用过程中如果有疑问，欢迎提出，我这边会尽快给予回复，另外还准备更新一篇来介绍这个库的一些功能。



