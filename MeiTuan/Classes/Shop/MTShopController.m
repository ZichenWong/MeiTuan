//
//  MTShopController.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/7/30.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTShopController.h"
#import "MTFoodDetailController.h"
#import "MTNavigationBar.h"

//头部视图的最大高度
#define KShopHeaderViewMaxHeight   180
//头部视图的最小高度
#define KShopHeaderViewMinHeight   64

@interface MTShopController ()

//头部视图
@property (nonatomic, weak) UIView *shopHeaderView;
//分享按钮
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;

@end

@implementation MTShopController

- (void)viewDidLoad
{
    
    //此方法优先于导航条加载
    [self setupUI];
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    
    self.navItem.title = @"黑暗料理";
    
    //默认导航条的背景图片完全透明
    self.navBar.bgImageView.alpha = 0;
    
    //设置导航条标题文字颜色完全透明
    self.navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.4 alpha:0]};
    
    //设置导航条右边分享按钮
    _rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_share"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navItem.rightBarButtonItem = _rightButtonItem;
    self.navBar.tintColor = [UIColor whiteColor];


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
    
    
    //透明度设置
    CGFloat alpha = [@(_shopHeaderView.bounds.size.height) resultWithValue1:HMValueMake(64, 1) andValue2:HMValueMake(180, 0)];
    
    self.navBar.bgImageView.alpha = alpha;
    
    // 设置导航条标题文字颜色和导航条背景变化是一样的
    self.navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.4 alpha:alpha]};
    
    //计算分享按钮的白色值
    CGFloat White = [@(_shopHeaderView.bounds.size.height) resultWithValue1:HMValueMake(64, 0.4) andValue2:HMValueMake(180, 1)];
    
    //设置分享按钮的颜色
    self.navBar.tintColor = [UIColor colorWithWhite:White alpha:1];
    
    //高度180用白色
    if (_shopHeaderView.bounds.size.height == KShopHeaderViewMaxHeight && self.statusBarStyle != UIStatusBarStyleLightContent)
    {
        self.statusBarStyle = UIStatusBarStyleLightContent;
        
    }//反之用黑色
    else if (_shopHeaderView.bounds.size.height == KShopHeaderViewMinHeight && self.statusBarStyle != UIStatusBarStyleDefault){
        self.statusBarStyle = UIStatusBarStyleDefault;
    }
    
    //恢复到初始值
    [pan setTranslation:CGPointZero inView:pan.view];
    
}

//- (CGFloat)resultWithConsult:(CGFloat)consult andConsult1:(CGFloat)consult1 andResult1:(CGFloat)result1 andConsult2:(CGFloat)consult2 andResult2:(CGFloat)result2 {
//    CGFloat a = (result1 - result2) / (consult1 - consult2);
//    CGFloat b = result1 - (a * consult1);
//    
//    
//    return a * consult + b;
//}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    MTFoodDetailController *foodDetailVC = [[MTFoodDetailController alloc] init];
//    
//    [self.navigationController pushViewController:foodDetailVC animated:YES];
//}

@end
