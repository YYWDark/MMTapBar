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
    self.dataSource = self;
    self.delegate = self;
    [self reload];
//    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//#pragma mark - UITableViewDataSource
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.dataArr.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
//    cell.textLabel.text = self.dataArr[indexPath.row];
////    cell.backgroundColor = [UIColor redColor];
//    return cell;
//}
//
////- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
////    id vc = [[NSClassFromString(self.dataArr[indexPath.row]) alloc] init];
////    [self.navigationController pushViewController:vc animated:YES];
////}
//
//#pragma mark - Getter
//- (UITableView *)tableView{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, self.view.frame.size.width, self.view.frame.size.height - kNavigationHeight ) style:UITableViewStylePlain];
//        _tableView.dataSource = self;
//        _tableView.delegate = self;
//        _tableView.scrollEnabled = YES;
//        _tableView.showsVerticalScrollIndicator = YES;
//        _tableView.showsHorizontalScrollIndicator = YES;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
//        
//    }
//    return _tableView;
//}
//
//- (NSMutableArray *)dataArr{
//    if (!_dataArr) {
//        _dataArr = [NSMutableArray array];
//        for (int index = 0; index < 30; index ++) {
//            [_dataArr addObject:[NSString stringWithFormat:@"第%d个单元格",index]];
//        }
//    }
//    return _dataArr;
//}

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
    return [UIColor blueColor];
}

- (CGFloat)tabBarViewControllerShowUnderlineHeight:(MMTabBarViewController *)tabBarViewController{
    return 2.0f;
}

//=====================================titles=====================================
- (UIColor *)tabBarViewControllerShowTitleUnSelectedColor:(MMTabBarViewController *)tabBarViewController{
    return [UIColor colorWithHexString:@"333333"];
}

- (UIColor *)tabBarViewControllerShowTitleSelectedColor:(MMTabBarViewController *)tabBarViewController{
    return [UIColor whiteColor];
}

//=====================================MarkView=====================================
//显示当前遮罩层的颜色
- (UIColor *)tabBarViewControllerShowMarkViewBackgroundColor:(MMTabBarViewController *)tabBarViewController{
    return [UIColor colorWithHexString:@"3EBFFF"];
}

#pragma mark - get
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        
        MMTabBarModel *model1 = [[MMTabBarModel alloc] init];
        model1.controllerClassName = @"BaseViewController";
        model1.controllerTitle = [NSString stringWithFormat:@"洛杉矶湖人"];
        
        MMTabBarModel *model2 = [[MMTabBarModel alloc] init];
        model2.controllerClassName = @"OneVC";
        model2.controllerTitle = [NSString stringWithFormat:@"雷霆"];
        
        MMTabBarModel *model3 = [[MMTabBarModel alloc] init];
        model3.controllerClassName = @"SecondVC";
        model3.controllerTitle = [NSString stringWithFormat:@"凯尔特人"];
        
        MMTabBarModel *model4 = [[MMTabBarModel alloc] init];
        model4.controllerClassName = @"UIViewController";
        model4.controllerTitle = [NSString stringWithFormat:@"尼克斯"];
        
        MMTabBarModel *model5 = [[MMTabBarModel alloc] init];
        model5.controllerClassName = @"UIViewController";
        model5.controllerTitle = [NSString stringWithFormat:@"明尼苏达森林狼"];
        
        MMTabBarModel *model6 = [[MMTabBarModel alloc] init];
        model6.controllerClassName = @"UIViewController";
        model6.controllerTitle = [NSString stringWithFormat:@"休斯顿火箭"];
        
        MMTabBarModel *model7 = [[MMTabBarModel alloc] init];
        model7.controllerClassName = @"UIViewController";
        model7.controllerTitle = [NSString stringWithFormat:@"印第安纳步行者"];
        
        MMTabBarModel *model8 = [[MMTabBarModel alloc] init];
        model8.controllerClassName = @"UIViewController";
        model8.controllerTitle = [NSString stringWithFormat:@"密尔沃基雄鹿"];
        
        MMTabBarModel *model9 = [[MMTabBarModel alloc] init];
        model9.controllerClassName = @"UIViewController";
        model9.controllerTitle = [NSString stringWithFormat:@"小牛"];
        
        MMTabBarModel *model10 = [[MMTabBarModel alloc] init];
        model10.controllerClassName = @"UIViewController";
        model10.controllerTitle = [NSString stringWithFormat:@"圣安东尼奥马刺"];
        
        [_dataArr addObject:model1];
        [_dataArr addObject:model2];
        [_dataArr addObject:model3];
        [_dataArr addObject:model4];
        [_dataArr addObject:model5];
        [_dataArr addObject:model6];
        [_dataArr addObject:model7];
        [_dataArr addObject:model8];
        [_dataArr addObject:model9];
        [_dataArr addObject:model10];
        
    }
    return _dataArr;
}
@end
