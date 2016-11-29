//
//  MMTapBarViewController.h
//  MMTapBar
//
//  Created by wyy on 16/11/22.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import "ViewController.h"
#import "MMTabBarModel.h"

typedef NS_ENUM(NSUInteger, MMTabBarViewGradientType) {
    MMTabBarViewGradientTypeNormal = 0,     //no underline and no mask
    MMTabBarViewGradientTypeUnderline = 1,  //only underline
    MMTabBarViewGradientTypeMasking= 2,     //only mask
};

@protocol MMTabBarViewDataSource;
@protocol MMTabBarViewDelegate;
@interface MMTabBarViewController : UIViewController
@property (nonatomic, weak) id<MMTabBarViewDataSource> dataSource;
@property (nonatomic, weak) id<MMTabBarViewDelegate> delegate;
@property (nonatomic, assign) MMTabBarViewGradientType gradientType;     //default is MMTabBarViewGradientTypeNormal

- (void)reload;
@end


@protocol MMTabBarViewDataSource <NSObject>
@required
- (NSArray *)infomationsForViewController:(MMTabBarViewController *)tabBarViewController;
- (NSUInteger )numberOfItemsInViewController:(MMTabBarViewController *)tabBarViewController;
- (MMTabBarModel *)infomationInViewController:(MMTabBarViewController *)tabBarViewController infoForItemAtIndex:(NSUInteger)index;
@end


@protocol MMTabBarViewDelegate <NSObject>
@optional
//=====================================TabBar=====================================
//显示当前titleScrollView背景的颜色  defalut is #485CD5
- (UIColor *)tabBarViewControllerShowTitleScrollViewBackgroudColor:(MMTabBarViewController *)tabBarViewController;
//显示当前titleScrollView的高度    defalut is 40.0f
- (CGFloat)tabBarViewControllerShowTitleScrollViewHeight:(MMTabBarViewController *)tabBarViewController;
//=====================================Titles=====================================
//显示当前title没有选中标题的颜色     defalut is blackColor
- (UIColor *)tabBarViewControllerShowTitleUnSelectedColor:(MMTabBarViewController *)tabBarViewController;
//显示当前title选中标题的颜色        defalut is whiteColor
- (UIColor *)tabBarViewControllerShowTitleSelectedColor:(MMTabBarViewController *)tabBarViewController;
//设置title到左右两边缘的距离          defalut is 10.0f;
- (CGFloat)tabBarViewControllerShowTitleMargin:(MMTabBarViewController *)tabBarViewController;
//=====================================Underline=====================================
//显示当前下划线背景颜色颜色          defalut is whiteColor
- (UIColor *)tabBarViewControllerShowUnderlineBackgroundColor:(MMTabBarViewController *)tabBarViewController;
//显示当前下划线高度                 defalut is 2.0
- (CGFloat)tabBarViewControllerShowUnderlineHeight:(MMTabBarViewController *)tabBarViewController;
//=====================================MarkView=====================================
//显示当前遮罩层的颜色               defalut is #333333
- (UIColor *)tabBarViewControllerShowMarkViewBackgroundColor:(MMTabBarViewController *)tabBarViewController;
@end


