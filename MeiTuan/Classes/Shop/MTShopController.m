//
//  MTShopController.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/7/30.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTShopController.h"
#import "MTFoodDetailController.h"

//头部视图的最大高度
#define KShopHeaderViewMaxHeight   180
//头部视图的最小高度
#define KShopHeaderViewMinHeight   64

@interface MTShopController ()

//头部视图
@property (nonatomic, weak) UIView *shopHeaderView;

@end

@implementation MTShopController

- (void)viewDidLoad
{
    
    //此方法优先于导航条加载
    [self setupUI];
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    self.navItem.title = @"66";
    
}

//界面搭建
- (void)setupUI
{
    //创建头部视图
    UIView *shopHeaderView = [[UIView alloc] init];
    
    shopHeaderView.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:shopHeaderView];
    
    //设置约束
    [shopHeaderView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.top.right.offset(0);
         make.height.offset(KShopHeaderViewMaxHeight);
     }];
    
    //添加平移手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    
    [self.view addGestureRecognizer:pan];
    
    //给全局属性赋值
    _shopHeaderView = shopHeaderView;
    

}


//平移手势
- (void)panGesture:(UIPanGestureRecognizer *)pan
{
    //获取平移距离
    CGPoint p = [pan translationInView:pan.view];
    
    //更新约束
    [_shopHeaderView mas_updateConstraints:^(MASConstraintMaker *make)
    {
//        make.height.offset(p.y + _shopHeaderView.bounds.size.height);
        if (p.y + _shopHeaderView.bounds.size.height <= 64)
        {
            make.height.offset(KShopHeaderViewMinHeight);
        } else if (p.y + _shopHeaderView.bounds.size.height >= 180)
        {
            make.height.offset(KShopHeaderViewMaxHeight);
        }
        else
        {
            make.height.offset(p.y + _shopHeaderView.bounds.size.height);
        }
            }];
    
    //恢复到初始值
    [pan setTranslation:CGPointZero inView:pan.view];
    
    
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    MTFoodDetailController *foodDetailVC = [[MTFoodDetailController alloc] init];
//    
//    [self.navigationController pushViewController:foodDetailVC animated:YES];
//}

@end
