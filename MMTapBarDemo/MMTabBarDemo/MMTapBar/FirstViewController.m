//
//  FirstViewController.m
//  MMTapBar
//
//  Created by wyy on 16/11/24.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import "FirstViewController.h"
#import "MMHeader.h"
#import "OneVC.h"
#import "SecondVC.h"
static NSString *cellID = @"MMCell";

@interface FirstViewController () <MMTabBarViewDataSource, MMTabBarViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMehod];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)initMehod{
    self.dataSource = self;
    self.delegate = self;
    //指定样式
    self.gradientType = MMTabBarViewGradientTypeMasking;
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

/*
#pragma mark - MMTabBarViewDelegate
//=====================================tabBar=====================================
- (UIColor *)tabBarViewControllerShowTitleScrollViewBackgroudColor:(MMTabBarViewController *)tabBarViewController{
    return [UIColor whiteColor];
}

- (CGFloat)tabBarViewControllerShowTitleScrollViewHeight:(MMTabBarViewController *)tabBarViewController{
    return 40.0f;
}

//=====================================Underline=====================================
- (UIColor *)tabBarViewControllerShowUnderlineBackgroundColor:(MMTabBarViewController *)tabBarViewController{
    return [UIColor colorWithHexString:@"3EBFFF"];
}

- (CGFloat)tabBarViewControllerShowUnderlineHeight:(MMTabBarViewController *)tabBarViewController{
    return 2.0f;
}

//=====================================titles=====================================
- (UIColor *)tabBarViewControllerShowTitleUnSelectedColor:(MMTabBarViewController *)tabBarViewController{
    return [UIColor colorWithHexString:@"333333"];
}

- (UIColor *)tabBarViewControllerShowTitleSelectedColor:(MMTabBarViewController *)tabBarViewController{
    return [UIColor colorWithHexString:@"FC6E68"];
}

- (CGFloat)tabBarViewControllerShowTitleMargin:(MMTabBarViewController *)tabBarViewController{
    return 20.0;
}
//=====================================MarkView=====================================
//显示当前遮罩层的颜色
- (UIColor *)tabBarViewControllerShowMarkViewBackgroundColor:(MMTabBarViewController *)tabBarViewController{
    return [UIColor colorWithHexString:@"3EBFFF"];
}
*/
#pragma mark - get
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        
        NSArray *data = @[@[@"OneVC",@"洛杉矶湖人"],@[@"SecondVC",@"凯尔特人"],@[@"ThirdVC",@"雷霆"],@[@"FourthVC",@"尼克斯"],@[@"FivethVC",@"圣安东尼奥马刺"],@[@"UIViewController",@"明尼苏达森林狼"],@[@"UIViewController",@"休斯顿火箭"],@[@"UIViewController",@"印第安纳步行者"],@[@"UIViewController",@"密尔沃基雄鹿"],@[@"UIViewController",@"小牛"],];
        
        for (int i = 0; i < data.count; i++) {
            [_dataArr addObject:[MMTabBarModel modelWithControllerClassName:[data[i] firstObject]  controllerTitle:[data[i] lastObject]]];
        }
        
     
    }
    return _dataArr;
}
@end
