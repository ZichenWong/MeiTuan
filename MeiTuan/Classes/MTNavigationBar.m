//
//  MTNavigationBar.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/7/30.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTNavigationBar.h"

@implementation MTNavigationBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        //取消导航条的阴影线
        [self setShadowImage:[UIImage new]];
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

        
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_navigationBar_white"]];
        [self addSubview:bgImageView];
        
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.edges.offset(0);
        }];
        
        //给全局属性赋值
        _bgImageView = bgImageView;
        
    }
    return self;
}
@end
