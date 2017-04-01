//
//  SecondViewController.m
//  MMTabBarDemo
//
//  Created by wyy on 2017/4/1.
//  Copyright © 2017年 yyx. All rights reserved.
//

#import "SecondViewController.h"
#import "MMHeader.h"
#import "OneVC.h"
#import "SecondVC.h"
@interface SecondViewController ()
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initMehod];
}

- (void)initMehod{
    //指定样式
    self.gradientType = MMTabBarViewGradientTypeUnderline;
    //制定布局方式 暂时为两种
    self.layoutType   = MMTabBarViewTextLayoutByEqualDivision;
    [self reload];
}

#pragma mark - MMTabBarViewDataSource
- (NSArray *)infomationsForViewController:(MMTabBarViewController *)tabBarViewController{
    return [self.dataArr copy];
}

- (NSUInteger )numberOfItemsInViewController:(MMTabBarViewController *)tabBarViewController {
    return self.dataArr.count;
}

- (MMTabBarModel *)infomationInViewController:(MMTabBarViewController *)tabBarViewController infoForItemAtIndex:(NSUInteger)index {
    return self.dataArr[index];
}

#pragma mark - get
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        NSArray *data = @[@[@"OneVC",@"洛杉矶湖人"],@[@"SecondVC",@"凯尔特人"],@[@"SecondVC",@"凯尔特人"],@[@"SecondVC",@"凯尔特人"]];
        for (int i = 0; i < data.count; i++) {
            [_dataArr addObject:[MMTabBarModel modelWithControllerClassName:[data[i] firstObject]  controllerTitle:[data[i] lastObject]]];
        }
    }
    return _dataArr;
}
@end
