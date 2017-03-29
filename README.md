
##1.支持的样式
目前支持三种样式：
```
typedef NS_ENUM(NSUInteger, MMTabBarViewGradientType) {
    MMTabBarViewGradientTypeNormal = 0,     //no underline and no mask
    MMTabBarViewGradientTypeUnderline = 1,  //only underline
    MMTabBarViewGradientTypeMasking= 2,     //only mask
};
```
默认样式为`MMTabBarViewGradientTypeNormal`。也就是下 **图1** 中的样式。
![图1.png](http://upload-images.jianshu.io/upload_images/307963-b66671b1e11de4b6.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![图2.png](http://upload-images.jianshu.io/upload_images/307963-3cedc7e211c857d9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![图3.png](http://upload-images.jianshu.io/upload_images/307963-2c0cd88cf56616eb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



##2.初始化方式

###Installation

1.using CocoaPods:
```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '6.0'

target 'TargetName' do
pod 'MMTapBar' ,’~> 0.0.2’
end
```
2.by cloning the project into your repository:

###How To Use：
> * 如demo中的`FirstViewController`继承于`MMTabBarViewController`
> * 签订`MMTabBarViewDataSource，MMTabBarViewDelegate` 两个协议。你可以参考`UITableViewDataSource`,`UITableViewDelegate`。`MMTabBarViewDataSource`是必须实现的，因为它提供驱动视图的数据。而`MMTabBarViewDelegate`协议是可选的，它提供了对视图布局的自定义方式。参考第三部分的扩展方式。

```
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
    self.gradientType = MMTabBarViewGradientTypeUnderline;
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
        
        NSArray *data = @[@[@"OneVC",@"洛杉矶湖人"],@[@"SecondVC",@"凯尔特人"],@[@"ThirdVC",@"雷霆"],@[@"FourthVC",@"尼克斯"],@[@"FivethVC",@"圣安东尼奥马刺"],@[@"UIViewController",@"明尼苏达森林狼"],@[@"UIViewController",@"休斯顿火箭"],@[@"UIViewController",@"印第安纳步行者"],@[@"UIViewController",@"密尔沃基雄鹿"],@[@"UIViewController",@"小牛"],];
        
        for (int i = 0; i < data.count; i++) {
            [_dataArr addObject:[MMTabBarModel modelWithControllerClassName:[data[i] firstObject]  controllerTitle:[data[i] lastObject]]];
        }
        
    }
    return _dataArr;
}
```

##3.通过可选的协议自定义自己想要的界面。

```
@protocol MMTabBarViewDelegate <NSObject>
@optional
//=====================================TabBar=====================================
//显示当前titleScrollView背景的颜色  defalut is #485CD5
- (UIColor *)tabBarViewControllerShowTitleScrollViewBackgroudColor:(MMTabBarViewController *)tabBarViewController;
//显示当前titleScrollView的高度    defalut is 40.0f
- (CGFloat)tabBarViewControllerShowTitleScrollViewHeight:(MMTabBarViewController *)tabBarViewController;
//=====================================Titles=====================================
//显示当前title没有选中标题的颜色     defalut is blackColor
- (UIColor *)tabBarViewControllerShowTitleUnSelectedColor:(MMTabBarViewController *)tabBarViewController;
//显示当前title选中标题的颜色        defalut is whiteColor
- (UIColor *)tabBarViewControllerShowTitleSelectedColor:(MMTabBarViewController *)tabBarViewController;
//设置title到左右两边缘的距离          defalut is 10.0f;
- (CGFloat)tabBarViewControllerShowTitleMargin:(MMTabBarViewController *)tabBarViewController;
//=====================================Underline=====================================
//显示当前下划线背景颜色颜色          defalut is whiteColor
- (UIColor *)tabBarViewControllerShowUnderlineBackgroundColor:(MMTabBarViewController *)tabBarViewController;
//显示当前下划线高度                 defalut is 2.0
- (CGFloat)tabBarViewControllerShowUnderlineHeight:(MMTabBarViewController *)tabBarViewController;
//=====================================MarkView=====================================
//显示当前遮罩层的颜色               defalut is #333333
- (UIColor *)tabBarViewControllerShowMarkViewBackgroundColor:(MMTabBarViewController *)tabBarViewController;
@end
```
##4.demo效果：
`MMTabBarViewGradientTypeMasking ` 没有扩展的样式：


![4.gif](http://upload-images.jianshu.io/upload_images/307963-06feaca999553355.gif?imageMogr2/auto-orient/strip)

其他样式请见demo
如果你觉得这篇文章对你有所帮助，欢迎like或star!谢谢！
文章地址:http://www.jianshu.com/p/084c660d5fc5
