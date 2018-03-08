//
//  PublicTableDataAndDelegate.h
//  AppExtension
//
//  Created by 创客金融 on 2018/3/8.
//  Copyright © 2018年 创客金融. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PublicTableDataAndDelegate : NSObject<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIViewController *argumentVC;

@end
