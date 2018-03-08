//
//  PublicTableDataAndDelegate.m
//  AppExtension
//
//  Created by 创客金融 on 2018/3/8.
//  Copyright © 2018年 创客金融. All rights reserved.
//

#import "PublicTableDataAndDelegate.h"

@interface PublicTableDataAndDelegate()

@property (nonatomic, strong) NSMutableArray *allDataArr;
@end


@implementation PublicTableDataAndDelegate

- (NSMutableArray *)allDataArr{
    if (!_allDataArr) {
        _allDataArr = [NSMutableArray array];
    }
    return _allDataArr;
}

- (instancetype)init{
    if (self = [super init]) {
        [self loadData];
    }
    return self;
}

- (void)loadData{
    NSUserDefaults *userDefault = [[NSUserDefaults alloc] initWithSuiteName:@"group.extenion"];
    NSArray *arr = [userDefault valueForKey:@"shareData"];
    self.allDataArr = [arr mutableCopy];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [self loadData];
    return self.allDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reusedID = @"lalala";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusedID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reusedID];
    }
    cell.textLabel.text = self.allDataArr[indexPath.row];
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc] init];
}

// 点击cell打开主程序
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.argumentVC.extensionContext) {
        [self.argumentVC.extensionContext openURL:[NSURL URLWithString:@"wocao://add"] completionHandler:nil];
    }
    
}


@end
