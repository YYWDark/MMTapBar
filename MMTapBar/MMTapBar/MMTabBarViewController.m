//
//  MMTapBarViewController.m
//  MMTapBar
//
//  Created by wyy on 16/11/22.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import "MMTabBarViewController.h"
#import "MMHeader.h"
#import "NSObject+Calculate.h"
#import "MMTitleScrollView.h"
#import "MMTabBarCell.h"
static NSString *identifer = @"cellID";

@interface MMTabBarViewController () <UICollectionViewDelegate ,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIScrollView     *titleScrollView;
@property (nonatomic, strong) UIView           *underline;
@property (nonatomic, strong) UIView           *maskView;

@property (nonatomic, strong) NSMutableArray *titleWidthArray;          // store title widths
@property (nonatomic, strong) NSMutableArray *leftMargins;              // store title originX
@property (nonatomic, strong) NSMutableArray *titlleLabels;             // 储存标题的容器

@property (nonatomic, assign) CGFloat titleContentWidth;                //titleScrollView 显示内容的总宽度
@property (nonatomic, assign) CGFloat tabBarHeight;                     //titleScrollView的高度 default is 40.0f
@property (nonatomic, assign) CGFloat underlineHeight;                  //default is 2.0f
@property (nonatomic, assign) CGFloat lastOffsetX;                      //记录上一次collectionView X轴的偏移量
@property (nonatomic, assign) CGFloat maskViewCornerRadius;             //阴影的圆角 default is 8.0f;

@property (nonatomic, assign) BOOL    isInTapAction;                    //是否正在响应点击的处理方法
@property (nonatomic, assign) NSUInteger pageIndex;                     //default is 0

@property (nonatomic, strong) UIColor *selectedTitleColor;              //标题选中字体的颜色  default is red
@property (nonatomic, strong) UIColor *unselectedTitleColor;            //标题没有选中的颜色  default is black
@property (nonatomic, strong) UIColor *underlineBackgroundColor;        //下划线背景颜色     default is black
@property (nonatomic, strong) UIColor *titleScrollViewBackgroundColor;  //default is white
@property (nonatomic, strong) UIColor *maskBackBackgroundColor;         //
@end

@implementation MMTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initMethod];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.titleScrollView.frame = CGRectMake(0, 0, self.view.width, _tabBarHeight);
    self.collectionView.frame  = CGRectMake(0, _tabBarHeight, self.view.width, self.view.height - _tabBarHeight);
    
    [self _calculateEachLabelTotalWidthAndTitleContentWidth];
    [self _layoutTitleScrollViewLayoutSubviews];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

#pragma mark - private method
- (void)_layoutTitleScrollViewLayoutSubviews {
   
     NSUInteger titleCount = [self.dataSource numberOfItemsInViewController:self];
     CGFloat leftMargin = titleHorizontalMargin;
     //layout labels
     for (int index = 0; index < titleCount; index ++) {
        [self.leftMargins addObject:@(leftMargin)];
        UILabel *label = [[UILabel alloc] init];
        MMTabBarModel *model = [self.dataSource infomationInViewController:self infoForItemAtIndex:index];
        label.text = model.controllerTitle;
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:titleFontSize];
        label.frame = CGRectMake(leftMargin, 0,[self.titleWidthArray[index] floatValue] - 2*titleHorizontalMargin, self.tabBarHeight);
        
        leftMargin += [self.titleWidthArray[index] floatValue] ;
        label.userInteractionEnabled = YES;
        label.tag = index;
        label.textColor = index?self.unselectedTitleColor:self.selectedTitleColor;
        [self.titlleLabels addObject:label];
        [self.titleScrollView addSubview:label];
         
        //addTapGesture
         UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(respondedToTapGestureRecognizer:)];
         [label addGestureRecognizer:tap];
    }
    
    
    [self _layoutGradientView:self.gradientType];
    
    self.titleScrollView.contentSize = CGSizeMake(self.titleContentWidth+10.0f, self.tabBarHeight);
}

- (void)_layoutGradientView:(MMTabBarViewGradientType)type{
    switch (type) {
        case MMTabBarViewGradientTypeUnderline:{
            self.underline.frame = CGRectMake(titleHorizontalMargin, self.tabBarHeight - self.underlineHeight, [self.titleWidthArray[0] floatValue] - 2*titleHorizontalMargin, self.underlineHeight);
            [self.titleScrollView addSubview:self.underline];

            break;}
        case MMTabBarViewGradientTypeMasking:{
            self.maskView.frame = CGRectMake(titleHorizontalMargin, 5, [self.titleWidthArray[0] floatValue] - 2*titleHorizontalMargin, self.tabBarHeight -10);
//            [self.titleScrollView addSubview:self.maskView];
            [self.titleScrollView insertSubview:self.maskView atIndex:0];
            break;}
        default:
            break;
    }
}
/**
 *  计算每个title的宽度 和titleScrollView显示的宽度
 */
- (void)_calculateEachLabelTotalWidthAndTitleContentWidth {
    CGFloat titleContentWidth = 0.0f;
    NSUInteger titleCount = [self.dataSource numberOfItemsInViewController:self];
    for (int index = 0; index < titleCount; index ++) {
        MMTabBarModel *model = [self.dataSource infomationInViewController:self infoForItemAtIndex:index];
        CGFloat calculate = [NSObject widthFromString:model.controllerTitle withFont:[UIFont systemFontOfSize:titleFontSize] constraintToHeight:self.tabBarHeight];
        CGFloat eachLabelTotalWidth = calculate + 2*titleHorizontalMargin;
        titleContentWidth += eachLabelTotalWidth;
        [self.titleWidthArray addObject:@(eachLabelTotalWidth)];
    }
    self.titleContentWidth = titleContentWidth;
}

- (void)_initMethod {
    self.titleWidthArray = [NSMutableArray array];
    self.leftMargins = [NSMutableArray array];
    self.titlleLabels = [NSMutableArray array];
    self.underlineHeight = 2.0f;
    self.tabBarHeight = 40.0f;
    self.maskViewCornerRadius = 8.0f;

    //type
    self.gradientType = MMTabBarViewGradientTypeMasking;
    
    //color
    self.selectedTitleColor = [UIColor redColor];
    self.unselectedTitleColor = [UIColor blackColor];
    self.underlineBackgroundColor = [UIColor redColor];
    self.titleScrollViewBackgroundColor = [UIColor whiteColor];
}

- (void)_updateUnderlineAtIndex:(NSUInteger)selectedIndex {
   [UIView animateWithDuration:.25 animations:^{
       switch (self.gradientType) {
           case MMTabBarViewGradientTypeUnderline:{
                self.underline.frame = CGRectMake([self.leftMargins[selectedIndex] floatValue], self.tabBarHeight - self.underlineHeight,[self.titleWidthArray[selectedIndex] floatValue] - 2*titleHorizontalMargin , self.underlineHeight);
               break;}
           case MMTabBarViewGradientTypeMasking:{
                self.maskView.frame = CGRectMake([self.leftMargins[selectedIndex] floatValue], 5,[self.titleWidthArray[selectedIndex] floatValue] - 2*titleHorizontalMargin , self.tabBarHeight - 10);
               break;}
               
           default:
               break;
       }
     
   }];
}

- (void)_updateSelectedTitle:(NSUInteger)selectedIndex {
    for (UILabel *label in self.titleScrollView.subviews) {
        if (![label isMemberOfClass:[UILabel class]]) continue;
        label.textColor = (selectedIndex == label.tag)?self.selectedTitleColor:self.unselectedTitleColor;
        if (selectedIndex == label.tag) {
            [self _setTitleLocationCenter:label];
        }
    }
}

- (void)_setTitleLocationCenter:(UILabel *)selectedLabel {
    CGFloat offsetX = MAX(0, (selectedLabel.center.x - self.view.width * 0.5));
    CGFloat maxOffsetX = MAX(0, (self.titleScrollView.contentSize.width - self.view.width));
    offsetX = MIN(offsetX, maxOffsetX);
    [self.titleScrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark -- custom dispaly style
- (void)_customTabBar {
    if ([self.delegate respondsToSelector:@selector(tabBarViewControllerShowTitleScrollViewBackgroudColor:)]) {
        self.titleScrollViewBackgroundColor = [self.delegate tabBarViewControllerShowTitleScrollViewBackgroudColor:self];
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBarViewControllerShowTitleScrollViewHeight:)]) {
        self.tabBarHeight = [self.delegate tabBarViewControllerShowTitleScrollViewHeight:self];
    }
}

- (void)_customTitles {
    if ([self.delegate respondsToSelector:@selector(tabBarViewControllerShowTitleUnSelectedColor:)]) {
       self.unselectedTitleColor =  [self.delegate tabBarViewControllerShowTitleUnSelectedColor:self];
    }
    
    if ([self.delegate respondsToSelector:@selector(tabBarViewControllerShowTitleSelectedColor:)]) {
        self.selectedTitleColor =  [self.delegate tabBarViewControllerShowTitleSelectedColor:self];
    }
}

- (void)_customUnderline {
    if ([self.delegate respondsToSelector:@selector(tabBarViewControllerShowUnderlineBackgroundColor:)]) {
        self.underlineBackgroundColor = [self.delegate tabBarViewControllerShowUnderlineBackgroundColor:self];
    }
    if ([self.delegate respondsToSelector:@selector(tabBarViewControllerShowUnderlineHeight:)]) {
        self.underlineHeight = [self.delegate tabBarViewControllerShowUnderlineHeight:self];
    }
}
#pragma mark - public method
- (void)reload{
    [self _customTabBar];
    [self _customTitles];
    [self _customUnderline];
    [self.collectionView reloadData];
}

#pragma mark - action
- (void)respondedToTapGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer {
    self.isInTapAction = YES;
    UILabel *label = (UILabel *)gestureRecognizer.view;
    if (label.tag == self.pageIndex) return;
    CGFloat offsetX = label.tag * self.view.width;
    self.pageIndex = label.tag;
    [self _updateUnderlineAtIndex:label.tag];
    [self.collectionView setContentOffset:CGPointMake(offsetX, -64) animated:NO];
    self.lastOffsetX = offsetX;
    [self _updateSelectedTitle:label.tag];
    self.isInTapAction = NO;
}


#pragma mark - UIcollectionView dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataSource numberOfItemsInViewController:self];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MMTabBarCell *cell = (MMTabBarCell*)[collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    cell.model = [self.dataSource infomationInViewController:self infoForItemAtIndex:indexPath.row];
    return cell;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isInTapAction) return;
    if ([scrollView isMemberOfClass:[UIScrollView class]]) {

    }else if ([scrollView isMemberOfClass:[UICollectionView class]]){
        CGFloat offsetX = scrollView.contentOffset.x;
       [self updateLinePositionWhenslidedOffsetX:offsetX];
        self.lastOffsetX = scrollView.contentOffset.x;
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.isInTapAction) return;
    if ([scrollView isMemberOfClass:[UIScrollView class]]) {
    }else if ([scrollView isMemberOfClass:[UICollectionView class]]){
        self.pageIndex = scrollView.contentOffset.x/self.view.width;
        [self _updateUnderlineAtIndex:self.pageIndex];
        [self _updateSelectedTitle:self.pageIndex];
    }
}

- (void)updateLinePositionWhenslidedOffsetX:(CGFloat)offsetX {
    if (self.titleWidthArray.count == 0) return;
    NSUInteger leftIndex =  offsetX/self.view.width;
    NSUInteger rightIndex =  leftIndex + 1;
    if (rightIndex >= self.titlleLabels.count )  return;
    
    //拿到滑动的距离
    CGFloat slidedDistance = offsetX - self.lastOffsetX;

    CGFloat rightCenter = [self.titlleLabels[rightIndex] left];
    CGFloat leftCenter  = [self.titlleLabels[leftIndex] left];
    //拿到两个文本之间left的差
    CGFloat centerDistance = rightCenter - leftCenter;
    CGFloat titleWidthDistance = [self.titleWidthArray[rightIndex] floatValue] - [self.titleWidthArray[leftIndex] floatValue];
    
    // 计算当前下划线偏移量
    CGFloat underLineoffsetX = slidedDistance * centerDistance / self.view.width;
    // 宽度递增偏移量
    CGFloat underLineWidth = slidedDistance * titleWidthDistance / self.view.width;
    
    self.underline.width += underLineWidth;
    self.underline.left += underLineoffsetX;
}

#pragma mark - get
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(self.view.width , self.view.height - _tabBarHeight);
        layout.minimumLineSpacing = .01f;
        layout.minimumInteritemSpacing = .01f;
        //设置滑动的方向
        [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        _collectionView = [[UICollectionView alloc] initWithFrame: CGRectZero collectionViewLayout:layout];
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.pagingEnabled = YES;
        //签订协议
        _collectionView.dataSource = self;
        _collectionView.delegate   =self;
        
        //注册cell
        [_collectionView registerClass:[MMTabBarCell class] forCellWithReuseIdentifier:identifer];
        
        [self.view addSubview:self.collectionView];
    }
    return _collectionView;
}

- (UIScrollView *)titleScrollView {
    if (!_titleScrollView) {
        _titleScrollView = [[UIScrollView alloc] init];
        _titleScrollView.backgroundColor = self.titleScrollViewBackgroundColor;
        _titleScrollView.showsHorizontalScrollIndicator = YES;
        _titleScrollView.delegate = self;
        [self.view addSubview:self.titleScrollView];
    }
    return _titleScrollView;
}

- (UIView *)underline {
    if (!_underline) {
        _underline = [[UIView alloc] init];
        _underline.backgroundColor = self.underlineBackgroundColor;
    }
    return _underline;
}

- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.backgroundColor = [UIColor lightGrayColor];
        _maskView.opaque = .1;
        _maskView.layer.masksToBounds = YES;
        _maskView.layer.cornerRadius = self.maskViewCornerRadius;
    }
    return _maskView;
}
@end
