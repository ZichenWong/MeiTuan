//
//  MTShopDetailController.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTShopDetailController.h"
#import "MTShopPOI_InfoModel.h"
#import "MTInfoModel.h"
#import "MTInfoView.h"

@interface MTShopDetailController ()

@end
//间距
#define KMargin  16
@implementation MTShopDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self setupUI];
}

- (void)setupUI
{
    //添加背景图片
    UIImageView *bgImageView = [[UIImageView alloc] init];
    [bgImageView sd_setImageWithURL:[NSURL URLWithString:[_shopPOIInfoModel.poi_back_pic_url stringByDeletingPathExtension]]];
    [self.view addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.offset(0);
     }];
    
    //添加关闭按钮
    UIButton *closeBtn = [[UIButton alloc] init];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close_normal"] forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:@"btn_close_selected"] forState:UIControlStateHighlighted];
    [self.view addSubview:closeBtn];
    
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.offset(0);
         make.bottom.offset(-60);
     }];
    
    [closeBtn addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //添加滚动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.top.right.offset(0);
         make.bottom.equalTo(closeBtn.mas_top).offset(-60);
     }];
    
    
    //创建容器视图
    UIView *contentView = [[UIView alloc] init];
    
    [scrollView addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.edges.offset(0);
         make.width.equalTo(scrollView);
     }];
    
    //店名
    UILabel *shopNameLabel = [UILabel makeLabelWithText:_shopPOIInfoModel.name andTextFont:14 andTextColor:[UIColor whiteColor]];
    
    [contentView addSubview:shopNameLabel];
    
    [shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.offset(0);
         make.top.offset(64);
     }];
    
    //起送价及配送
    UILabel *shopTipLabel = [UILabel makeLabelWithText:[NSString stringWithFormat:@"%@ | %@ | %@", _shopPOIInfoModel.min_price_tip, _shopPOIInfoModel.shipping_fee_tip, _shopPOIInfoModel.delivery_time_tip] andTextFont:12 andTextColor:[UIColor colorWithWhite:1 alpha:0.9]];
    
    [contentView addSubview:shopTipLabel];
    
    [shopTipLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.offset(0);
         make.top.equalTo(shopNameLabel.mas_bottom).offset(KMargin * 0.5);
     }];
    
    //折扣信息
    UILabel *shopDiscountLabel = [UILabel makeLabelWithText:@"折扣信息" andTextFont:16 andTextColor:[UIColor whiteColor]];
    [contentView addSubview:shopDiscountLabel];
    
    [shopDiscountLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.offset(0);
         make.top.equalTo(shopTipLabel.mas_bottom).offset(KMargin * 2.5);
     }];
    
    //折扣信息两边的线
    UIView *shopDiscountLineViewLeft = [[UIView alloc] init];
    shopDiscountLineViewLeft.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:shopDiscountLineViewLeft];
    
    [shopDiscountLineViewLeft mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.offset(KMargin);
         make.height.offset(1);
         make.right.equalTo(shopDiscountLabel.mas_left).offset(-KMargin);
         make.centerY.equalTo(shopDiscountLabel).offset(0);
     }];
    
    
    UIView *shopDiscountLineViewRight = [[UIView alloc] init];
    shopDiscountLineViewRight.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:shopDiscountLineViewRight];
    
    [shopDiscountLineViewRight mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.offset(-KMargin);
         make.height.offset(1);
         make.left.equalTo(shopDiscountLabel.mas_right).offset(KMargin);
         make.centerY.equalTo(shopDiscountLabel).offset(0);
     }];
    
    //优惠信息
    UIStackView *stackView = [[UIStackView alloc] init];
    
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.distribution = UIStackViewDistributionFillEqually;
    stackView.spacing = 10;
    
    //循环创建infoModel
    for (MTInfoModel *infoModel in _shopPOIInfoModel.discounts)
    {
        MTInfoView *infoView = [[MTInfoView alloc] init];
        infoView.infoModel = infoModel;
        
        [stackView addArrangedSubview:infoView];
    }
    
    [contentView addSubview:stackView];
    
    [stackView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.offset(KMargin);
         make.right.offset(-KMargin);
         make.top.equalTo(shopDiscountLabel.mas_bottom).offset(KMargin);
         make.height.offset(_shopPOIInfoModel.discounts.count * 30);
     }];
    
    //折扣信息
    UILabel *shopBulletinLabel = [UILabel makeLabelWithText:@"公告信息" andTextFont:16 andTextColor:[UIColor whiteColor]];
    [contentView addSubview:shopBulletinLabel];
    
    [shopBulletinLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.centerX.offset(0);
         make.top.equalTo(stackView.mas_bottom).offset(KMargin * 2.5);
     }];
    
    //折扣信息两边的线
    UIView *shopBulletinLineViewLeft = [[UIView alloc] init];
    shopBulletinLineViewLeft.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:shopBulletinLineViewLeft];
    
    [shopBulletinLineViewLeft mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.offset(KMargin);
         make.height.offset(1);
         make.right.equalTo(shopBulletinLabel.mas_left).offset(-KMargin);
         make.centerY.equalTo(shopBulletinLabel).offset(0);
     }];
    
    
    UIView *shopBulletinLineViewRight = [[UIView alloc] init];
    shopBulletinLineViewRight.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:shopBulletinLineViewRight];
    
    [shopBulletinLineViewRight mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.right.offset(-KMargin);
         make.height.offset(1);
         make.left.equalTo(shopBulletinLabel.mas_right).offset(KMargin);
         make.centerY.equalTo(shopBulletinLabel).offset(0);
     }];
    
    //商家公告信息
    UILabel *shopBulletionInfoLabel = [UILabel makeLabelWithText:_shopPOIInfoModel.bulletin andTextFont:12 andTextColor:[UIColor colorWithWhite:1 alpha:0.9]];
    [contentView addSubview:shopBulletionInfoLabel];
    //自动换行
    shopBulletionInfoLabel.numberOfLines = 0;
    
    [shopBulletionInfoLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.left.offset(KMargin);
         make.top.equalTo(shopBulletinLabel.mas_bottom).offset(KMargin);
         make.right.offset(-KMargin);
         make.bottom.offset(-KMargin);
     }];
    
}

//点击关闭按钮
- (void)closeBtnClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


//设置状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;


}
@end
