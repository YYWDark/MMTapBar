//
//  BaseViewController.m
//  MMTapBar
//
//  Created by wyy on 16/11/28.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import "OneVC.h"
#import "MJRefresh.h"
static const CGFloat kNavigationHeight = 0.0;
static NSString *cellID = @"MMCell";

@interface OneVC () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end
@implementation OneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.tableView.frame = CGRectMake(0, kNavigationHeight, self.view.frame.size.width, self.view.frame.size.height - kNavigationHeight );
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    OneVC *vc = [[OneVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Getter
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, self.view.frame.size.width, self.view.frame.size.height - kNavigationHeight ) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = YES;
        _tableView.showsVerticalScrollIndicator = YES;
        _tableView.showsHorizontalScrollIndicator = YES;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        __unsafe_unretained UITableView *tableView = self.tableView;
        
        // 下拉刷新
        tableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 结束刷新
                [tableView.mj_header endRefreshing];
            });
        }];
        
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        tableView.mj_header.automaticallyChangeAlpha = YES;
        
        // 上拉刷新
        tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                // 结束刷新
                [tableView.mj_footer endRefreshing];
            });
        }];

    }
    return _tableView;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        for (int index = 0; index < 30; index ++) {
            [_dataArr addObject:[NSString stringWithFormat:@"第%d个单元格",index]];
        }
    }
    return _dataArr;
}

@end
