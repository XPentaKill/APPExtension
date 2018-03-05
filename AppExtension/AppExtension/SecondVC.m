//
//  SecondVC.m
//  AppExtension
//
//  Created by 创客金融 on 2018/3/1.
//  Copyright © 2018年 创客金融. All rights reserved.
//

#import "SecondVC.h"
#import "ViewController.h"

@interface SecondVC ()
@property (nonatomic, strong) UITextField *textFd;
@end

@implementation SecondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *textF = [[UITextField alloc] initWithFrame:CGRectMake(50, 200, 260, 50)];
    textF.font = [UIFont systemFontOfSize:15];
    textF.borderStyle = UITextBorderStyleLine;
    [self.view addSubview:textF];
    self.textFd = textF;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 250, 50, 45);
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor blueColor];
    [btn addTarget:self action:@selector(okBtnClick) forControlEvents:UIControlEventTouchUpInside
     ];
    [self.view addSubview:btn];
    
}

- (void)okBtnClick{
    NSString *str = self.textFd.text;
    self.change(str);
    
}

@end
