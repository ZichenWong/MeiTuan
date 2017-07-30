//
//  MTBaseController.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/7/30.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTBaseController.h"

@interface MTBaseController ()

@end

@implementation MTBaseController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //每一个继承该类的控制器都创建一个导航条
    UINavigationBar *navBar = [[UINavigationBar alloc] init];
    //添加到主视图上
    [self.view addSubview:navBar];
    
    //设置导航条的约束
    [navBar mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.top.right.offset(0);
         make.height.offset(64);
     }];
    
    //给导航条添加item
    UINavigationItem *navItem = [[UINavigationItem alloc] init];
    
    [navBar setItems:@[navItem]];
    
    //给全局属性赋值
    _navBar = navBar;
    _navItem = navItem;
}

//内存警告处理
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if (self.isViewLoaded && self.view.window == nil)
    {
        self.view = nil;
    }
}




@end
