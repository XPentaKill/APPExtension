//
//  ViewController.m
//  AppExtension
//
//  Created by 创客金融 on 2018/2/28.
//  Copyright © 2018年 创客金融. All rights reserved.
//

#import "ViewController.h"
#import "SecondVC.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *arrM;
@property (nonatomic, strong) SecondVC *svc;
@end

@implementation ViewController

- (NSMutableArray *)arrM{
    if (!_arrM) {
        NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.extenion"];
        NSArray *arr = [userDefault valueForKey:@"shareData"];
        _arrM = [arr mutableCopy];
    }
    return _arrM;
}

- (SecondVC *)svc{
    if (!_svc) {
        _svc = [[SecondVC alloc] init];
    }
    return _svc;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"第一个控制器";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(add)];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 44;
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:table];
    self.table = table;
    
    // block添加数据
    __block typeof(self) bself = self;
    self.svc.change = ^(NSString * MM){
        
        if (MM.length > 0) {
            [bself.arrM addObject:MM];
            [bself.table reloadData];
            NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.extenion"];
           NSArray *arr = [userDefault valueForKey:@"shareData"];
            NSMutableArray *shareArr = [NSMutableArray arrayWithArray:arr];
            [shareArr insertObject:MM atIndex:0];
            [userDefault setObject:shareArr forKey:@"shareData"];
            [userDefault synchronize];
        }
        [bself.navigationController popViewControllerAnimated:YES];
        
    };
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrM.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reusedID = @"lalala";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedID];
    }
    cell.textLabel.text = self.arrM[indexPath.row];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (void)add{
    [self.navigationController pushViewController:self.svc animated:YES];
}

@end
