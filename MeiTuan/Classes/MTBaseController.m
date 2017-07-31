//
//  MTBaseController.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/7/30.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTBaseController.h"
#import "MTNavigationBar.h"

@interface MTBaseController ()

@end

@implementation MTBaseController


- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        //每一个继承该类的控制器都创建一个导航条
        MTNavigationBar *navBar = [[MTNavigationBar alloc] init];

        
        //给导航条添加item
        UINavigationItem *navItem = [[UINavigationItem alloc] init];
        
        [navBar setItems:@[navItem]];
        
        //给全局属性赋值
        _navBar = navBar;
        _navItem = navItem;
    }
    
    return self;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //添加到主视图上
    [self.view addSubview:_navBar];
    
    //设置导航条的约束
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.top.right.offset(0);
         make.height.offset(64);
     }];
    
    
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

//重写属性的set方法
- (void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;

    [self setNeedsStatusBarAppearanceUpdate];
}

//设置状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return self.statusBarStyle;
}




@end
