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
#import "MTShopOrderController.h"
#import "MTShopCommentController.h"
#import "MTShopInfoController.h"
#import "MTShopPOI_InfoModel.h"
#import "MTShopHeaderView.h"
#import "MTShopOrderCategoryModel.h"

//头部视图的最大高度
#define KShopHeaderViewMaxHeight   180
//头部视图的最小高度
#define KShopHeaderViewMinHeight   64

@interface MTShopController ()<UIScrollViewDelegate>

//头部视图
@property (nonatomic, weak) UIView *shopHeaderView;
//分享按钮
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;
//标签视图
@property (nonatomic, weak) UIView *shopTagView;
//指示条
@property (nonatomic, weak) UIView *shopTageLineView;
//滚动视图
@property (nonatomic, weak) UIScrollView *scrollView;
//头部模型数据
@property (nonatomic, strong) MTShopPOI_InfoModel *shopPOI_InfoModel;
//保存所有实物模型
@property (nonatomic, strong) NSArray *categoryData;


@end

@implementation MTShopController

- (void)viewDidLoad
{
    
    //加载数据
    [self loadFoodData];
    //此方法优先于导航条加载
    [self setupUI];
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self settingNormal];


}

//常规设置
- (void)settingNormal
{
    self.navItem.title = @"黑暗料理";
    
    //默认导航条的背景图片完全透明
    self.navBar.bgImageView.alpha = 0;
    
    //设置导航条标题文字颜色完全透明
    self.navBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithWhite:0.4 alpha:0]};
    
    //设置导航条右边分享按钮
    _rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_share"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navItem.rightBarButtonItem = _rightButtonItem;
    self.navBar.tintColor = [UIColor whiteColor];
    
    //添加平移手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    
    [self.view addGestureRecognizer:pan];
    
}

//界面搭建
- (void)setupUI
{
    [self settingShopHeaderView];
    
    [self settingShopTagView];
    
    [self settingShopScrollView];

}

//创建头部视图
- (void)settingShopHeaderView
{
    //创建头部视图
    MTShopHeaderView *shopHeaderView = [[MTShopHeaderView alloc] init];
    
    shopHeaderView.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:shopHeaderView];
    
    //设置约束
    [shopHeaderView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.top.right.offset(0);
         make.height.offset(KShopHeaderViewMaxHeight);
     }];
    
    
    //给全局属性赋值
    _shopHeaderView = shopHeaderView;
    
    //给头部视图传模型
    shopHeaderView.shopPOI_infoModel = _shopPOI_InfoModel;


}

//创建标签栏
- (void)settingShopTagView
{
    UIView *shopTagView = [[UIView alloc] init];
    shopTagView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shopTagView];
    
    [shopTagView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.right.offset(0);
        make.top.equalTo(_shopHeaderView.mas_bottom).offset(0);
        make.height.offset(44);
    }];
    
    _shopTagView = shopTagView;
    
    //创建标签栏中的按钮
    UIButton *orderButton = [self makeShopTagViewButtonWithTitle:@"点菜"];
    [self makeShopTagViewButtonWithTitle:@"评价"];
    [self makeShopTagViewButtonWithTitle:@"商家"];
    
    [shopTagView.subviews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.offset(0);
    }];
    
    [shopTagView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    //添加指示条
    UIView *shopTagLineView = [[UIView alloc] init];
    shopTagLineView.backgroundColor = [UIColor primaryYellowColor];
    [shopTagView addSubview:shopTagLineView];
    
    [shopTagLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.offset(50);
        make.height.offset(4);
        make.bottom.offset(0);
        make.centerX.equalTo(orderButton).offset(0);
    }];
    
    //给全局属性赋值
    _shopTageLineView = shopTagLineView;
}


//创建标签栏中的按钮
- (UIButton *)makeShopTagViewButtonWithTitle:(NSString *)title
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //给按钮添加监听事件
    [button addTarget:self action:@selector(shopTagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //标签视图中的子控件数量作为按钮的tag
    button.tag = _shopTagView.subviews.count;
    
    
    [_shopTagView addSubview:button];
    
    return button;
}

//点击标签栏中的按钮调用
- (void)shopTagButtonClick:(UIButton *)button
{
    //动画的方法让scrollView中的内容滚动
    [_scrollView setContentOffset:CGPointMake(button.tag * _scrollView.bounds.size.width, 0) animated:YES];
}

//创建滚动视图
- (void)settingShopScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.bottom.right.offset(0);
         make.top.equalTo(_shopTagView.mas_bottom).offset(0);
     }];
    
    //创建三个控制器
    MTShopOrderController *vc1 = [[MTShopOrderController alloc] init];
    //给点菜控制器传数据
    vc1.categoryData = _categoryData;
    
    MTShopCommentController *vc2 = [[MTShopCommentController alloc] init];
    MTShopInfoController *vc3 = [[MTShopInfoController alloc] init];
    
    //把三个控制器保存在一个数组里
    NSArray *vcs = @[vc1, vc2, vc3];
    
    
    for (UIViewController *vc in vcs)
    {
        [scrollView addSubview:vc.view];
        
        [self addChildViewController:vc];
        
        [vc didMoveToParentViewController:self];
    }
    
    [scrollView.subviews mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.bottom.offset(0);
        make.width.height.equalTo(scrollView);
    }];
    
    [scrollView.subviews mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    scrollView.delegate = self;
    
    //给全局属性赋值
    _scrollView = scrollView;
}

//监听scrollView滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //取小数页
    CGFloat page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //计算指示条每一次位移的距离
    CGFloat transformOnceX = _shopTagView.bounds.size.width / (_shopTagView.subviews.count - 1);
    
    //设置指示条水平方向偏移
    _shopTageLineView.transform = CGAffineTransformMakeTranslation(transformOnceX * page, 0);
}

//手指滚动停下来调用的方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    //取整页数
    NSInteger page = scrollView.contentOffset.x / scrollView.bounds.size.width;
    //遍历标签栏中的所有子控件
    for (NSInteger i = 0; i < _shopTagView.subviews.count; i++)
    {
        UIButton *btn = _shopTagView.subviews[i];

        if ([btn isKindOfClass:[UIButton class]])
        {
            if (page == i)
            {
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
            } else
            {
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
            }
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    [self scrollViewDidEndDecelerating:scrollView];
}

//平移手势
- (void)panGesture:(UIPanGestureRecognizer *)pan
{
    //获取平移距离
    CGPoint p = [pan translationInView:pan.view];
    
    //更新约束
    [_shopHeaderView mas_updateConstraints:^(MASConstraintMaker *make)
    {
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

//加载数据
- (void)loadFoodData
{
    ///加载头部视图数据
    NSData *data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"food.json" withExtension:nil]];
    
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    NSDictionary *poi_dict = jsonDict[@"data"][@"poi_info"];
    
    MTShopPOI_InfoModel *poi_infoModel = [MTShopPOI_InfoModel shopPOI_infoWithDict:poi_dict];
    
    _shopPOI_InfoModel = poi_infoModel;
    
    
    
    ///加载食物模型数据
    NSArray *food_spu_tagsDictArray = jsonDict[@"data"][@"food_spu_tags"];
    
    //创建可变数组用来保存食物类型模型
    NSMutableArray *categoryArrM = [NSMutableArray arrayWithCapacity:food_spu_tagsDictArray.count];
    
    for (NSDictionary *categoryDict in food_spu_tagsDictArray)
    {
        MTShopOrderCategoryModel *categoryModel = [MTShopOrderCategoryModel shopOrderCategoryWithDict:categoryDict];
        [categoryArrM addObject:categoryModel];
    }
    
    //赋值给全局变量
    _categoryData = categoryArrM.copy;
}


@end
