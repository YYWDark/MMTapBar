//
//  MMTabBarCell.m
//  MMTapBar
//
//  Created by wyy on 16/11/22.
//  Copyright © 2016年 yyx. All rights reserved.
//

#import "MMTabBarCell.h"
#import "MMHeader.h"
@interface MMTabBarCell ()

@end
@implementation MMTabBarCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
    }
    return self;
}

- (void)_updateInformationWithModel:(MMTabBarModel *)model{
    if (self.subviews) {
        for (UIView * view in self.subviews) {
            [view removeFromSuperview];
        }
    }
    
    UIViewController * vc = [[NSClassFromString(model.controllerClassName) alloc] init];
    vc.view.frame = self.bounds;
//    vc.view.backgroundColor = [UIColor randomColor];
    [self addSubview:vc.view];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:vc.view.bounds];
//    label.text = model.controllerTitle;
//    label.textAlignment = 1;
//    label.font = [UIFont systemFontOfSize:40];
//    [vc.view addSubview:label];
}

- (void)setModel:(MMTabBarModel *)model{
    if (_model != model) {
        _model = model;
        [self _updateInformationWithModel:model];
    }
}
@end
