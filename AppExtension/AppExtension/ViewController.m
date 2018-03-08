//
//  ViewController.m
//  AppExtension
//
//  Created by 创客金融 on 2018/2/28.
//  Copyright © 2018年 创客金融. All rights reserved.
//

#import "ViewController.h"
#import "PublicTableDataAndDelegate.h"

#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *arrM;
@property (nonatomic, strong) PublicTableDataAndDelegate *publicTableDD;
@end

@implementation ViewController

- (PublicTableDataAndDelegate *)publicTableDD{
    if (!_publicTableDD) {
        _publicTableDD = [[PublicTableDataAndDelegate alloc] init];
        _publicTableDD.argumentVC = self;
    }
    return _publicTableDD;
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
    table.delegate = self.publicTableDD;
    table.dataSource = self.publicTableDD;
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
            
            NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.extenion"];
           NSArray *arr = [userDefault valueForKey:@"shareData"];
            NSMutableArray *shareArr = [NSMutableArray arrayWithArray:arr];
            [shareArr insertObject:MM atIndex:0];
            [userDefault setObject:shareArr forKey:@"shareData"];
            [userDefault synchronize];
            
            
            [bself.table reloadData];
        }
        [bself.navigationController popViewControllerAnimated:YES];
        
    };
}

- (void)add{
    [self.navigationController pushViewController:self.svc animated:YES];
}

@end
