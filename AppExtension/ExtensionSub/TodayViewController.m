//
//  TodayViewController.m
//  ExtensionSub
//
//  Created by 创客金融 on 2018/3/1.
//  Copyright © 2018年 创客金融. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "PublicTableDataAndDelegate.h"

@interface TodayViewController () <NCWidgetProviding>
@property (nonatomic, strong) UITableView *table;
@property (nonatomic, strong) PublicTableDataAndDelegate *publicDD;
@end
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@implementation TodayViewController

- (PublicTableDataAndDelegate *)publicDD{
    if (!_publicDD) {
        _publicDD = [[PublicTableDataAndDelegate alloc] init];
        _publicDD.argumentVC = self;
    }
    return _publicDD;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStyleGrouped];
    table.delegate = self.publicDD;
    table.dataSource = self.publicDD;
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
