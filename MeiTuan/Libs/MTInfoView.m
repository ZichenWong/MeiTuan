//
//  MTInfoView.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTInfoView.h"
#import "MTInfoModel.h"

@interface MTInfoView ()
//图标
@property (nonatomic, weak) UIImageView *iconView;
//优惠信息
@property (nonatomic, weak) UILabel *infoLabel;

@end

@implementation MTInfoView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    //图标
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    [iconView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.top.bottom.offset(0);
        make.width.equalTo(iconView.mas_height);
    }];
    
    //优惠信息
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.text = @"啊啊啊啊啊 啊啊啊 啊啊啊啊啊啊";
    [self addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(iconView.mas_right).offset(8);
        make.centerY.offset(0);
    }];
    
    //给全局属性赋值
    _iconView = iconView;
    _infoLabel = infoLabel;
}


//给模型加载数据
- (void)setInfoModel:(MTInfoModel *)infoModel
{
    _infoModel = infoModel;

    [_iconView sd_setImageWithURL:[NSURL URLWithString:infoModel.icon_url]];

    _infoLabel.text = infoModel.info;
    
}
@end
