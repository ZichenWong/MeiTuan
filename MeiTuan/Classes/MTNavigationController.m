//
//  MTNavigationController.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/7/30.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTNavigationController.h"
#import "MTBaseController.h"

@interface MTNavigationController ()

@end

@implementation MTNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //隐藏导航条
    self.navigationBar.hidden = YES;
}

- (void)pushViewController:(MTBaseController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    //只给除导航控制器之外的其余子控制器添加左边返回按钮
    if (self.childViewControllers.count > 1)
    {
        //给导航条设置左边按钮
        viewController.navItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_backItem"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnClick)];
    }
    
    
}


- (void)backBtnClick
{
    //点击按钮返回
    [self popViewControllerAnimated:YES];

}

//子控制器设置状态栏样式
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return self.topViewController;
}
@end
