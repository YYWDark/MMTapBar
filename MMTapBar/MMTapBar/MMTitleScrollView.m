//
//  MMTitleScrollView.m
//  MMTapBar
//
//  Created by wyy on 16/11/22.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import "MMTitleScrollView.h"

@interface MMTitleScrollView () <UIScrollViewDelegate>
@property (nonatomic, strong) CALayer *underline;
@end

@implementation MMTitleScrollView
- (instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = YES;
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"x %lf",scrollView.contentOffset.x);
}
@end
