//
//  SecondVC.h
//  AppExtension
//
//  Created by 创客金融 on 2018/3/1.
//  Copyright © 2018年 创客金融. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondVC : UIViewController
@property (nonatomic, copy) void (^change)(NSString *);
@end
