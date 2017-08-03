//
//  MTShopHeaderView.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTShopHeaderView.h"
#import "MTShopPOI_InfoModel.h"
#import "MTInfoLoopView.h"
#import "MTShopDetailController.h"
#import "MTShopDetailAnimator.h"

@interface MTShopHeaderView ()
//背景view
@property (nonatomic, weak) UIImageView *backImageView;
//头像
@property (nonatomic, weak) UIImageView *avatarView;
//店名
@property (nonatomic, weak) UILabel *nameLabel;
//商家公告
@property (nonatomic, weak) UILabel *bulletinLabel;
//轮播视图
@property (nonatomic, weak) MTInfoLoopView *loopView;
//转场动画对象
@property (nonatomic, strong) MTShopDetailAnimator *animator;

@end
@implementation MTShopHeaderView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    
    //添加背景图片
    UIImageView *backImageView = [[UIImageView alloc] init];
    [self addSubview:backImageView];
    
    //设置填充模式
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.edges.offset(0);
    }];
    
    
    //轮播视图
    MTInfoLoopView *loopView = [[MTInfoLoopView alloc] init];
    loopView.clipsToBounds = YES;
    [self addSubview:loopView];
    
    [loopView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.offset(-8);
        make.height.offset(20);
    }];
    
    //轮播视图右边的小箭头
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow_white"]];
    [loopView addSubview:arrowView];
    
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.right.offset(0);
        make.centerY.offset(0);
    }];

    //虚线
    UIView *dashLineView = [[UIView alloc] init];
    dashLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage dashLineViewWithColor:[UIColor whiteColor]]];
    [self addSubview:dashLineView];
    
    [dashLineView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.equalTo(loopView).offset(0);
        make.right.offset(0);
        make.bottom.equalTo(loopView.mas_top).offset(-8);
        make.height.offset(1);
    }];
    
    
    //头像
    UIImageView *avatarView = [[UIImageView alloc] init];
    avatarView.backgroundColor = [UIColor blueColor];
    [self addSubview:avatarView];
    
    avatarView.layer.cornerRadius = 32;
    avatarView.clipsToBounds = YES;
    avatarView.layer.borderColor = [UIColor colorWithWhite:1 alpha:0.7].CGColor;
    avatarView.layer.borderWidth = 2;
    avatarView.contentMode = UIViewContentModeScaleAspectFill;
    
    [avatarView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.equalTo(dashLineView).offset(0);
        make.bottom.equalTo(dashLineView.mas_top).offset(-8);
        make.width.height.offset(64);
    }];
    
    
    //店名
    UILabel *nameLabel = [UILabel makeLabelWithText:@"粮新发现(天安门店)" andTextFont:16 andTextColor:[UIColor whiteColor]];
    [self addSubview:nameLabel];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.equalTo(avatarView.mas_right).offset(16);
        make.centerY.equalTo(avatarView).offset(-16);
    }];
    
    
    //商家公告
    UILabel *bulletinLabel = [UILabel makeLabelWithText:@"吼吼吼吼" andTextFont:14 andTextColor:[UIColor colorWithWhite:1 alpha:0.9]];
    [self addSubview:bulletinLabel];
    
    [bulletinLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(nameLabel).offset(0);
        make.centerY.equalTo(avatarView).offset(16);
        make.right.offset(-16);
    }];
    
    
    _backImageView = backImageView;
    _avatarView = avatarView;
    _nameLabel = nameLabel;
    _bulletinLabel = bulletinLabel;
    _loopView = loopView;
    
    //给轮播视图添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loopViewClick)];
    
    [loopView addGestureRecognizer:tap];
    
    
}

//点击轮播视图
- (void)loopViewClick
{
    MTShopDetailController *detailVC = [[MTShopDetailController alloc] init];
    
    detailVC.shopPOIInfoModel = _shopPOI_infoModel;
    
    detailVC.modalPresentationStyle = UIModalPresentationCustom;
    
    _animator = [[MTShopDetailAnimator alloc] init];
    
    detailVC.transitioningDelegate = _animator;
    
    [self.viewController presentViewController:detailVC animated:YES completion:nil];
    
}



//给子控件设置数据
- (void)setShopPOI_infoModel:(MTShopPOI_InfoModel *)shopPOI_infoModel
{
    _shopPOI_infoModel = shopPOI_infoModel;

    NSString *bgImageURLStr = [shopPOI_infoModel.poi_back_pic_url stringByDeletingPathExtension];

    [_backImageView sd_setImageWithURL:[NSURL URLWithString:bgImageURLStr]];
    
    //头像
    [_avatarView sd_setImageWithURL:[NSURL URLWithString:[shopPOI_infoModel.pic_url stringByDeletingPathExtension]]];

    //店名
    _nameLabel.text = shopPOI_infoModel.name;
        
    //商家公告
    _bulletinLabel.text = shopPOI_infoModel.bulletin;
    
    //优惠信息
    _loopView.discounts = shopPOI_infoModel.discounts;
}
@end
