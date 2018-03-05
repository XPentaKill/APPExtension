//
//  TodayViewController.m
//  ExtensionSub
//
//  Created by 创客金融 on 2018/3/1.
//  Copyright © 2018年 创客金融. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) NSMutableArray *arrM;
@end
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation TodayViewController

- (NSMutableArray *)arrM{
    if (!_arrM) {
        _arrM = [NSMutableArray array];
    }
    return _arrM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.extenion"];
    NSArray *arr = [userDefault valueForKey:@"shareData"];
    self.arrM = [arr mutableCopy];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 44;
    table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    table.showsVerticalScrollIndicator = NO;
    table.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:table];
    self.table = table;
    
    if (@available(iOS 10.0, *)) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeExpanded;
    } else {
        // Fallback on earlier versions
    }
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

// 点击cell打开主程序
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.extensionContext openURL:[NSURL URLWithString:@"wocao://home"] completionHandler:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {


    completionHandler(NCUpdateResultNewData);
}

- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets {
    return UIEdgeInsetsZero;
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize {
    if (@available(iOS 10.0, *)) {
        if (activeDisplayMode == NCWidgetDisplayModeExpanded) {
            self.preferredContentSize = CGSizeMake(0, 300);
        }else{
            self.preferredContentSize = maxSize;
        }
    } else {
        // Fallback on earlier versions
    }
}



@end
