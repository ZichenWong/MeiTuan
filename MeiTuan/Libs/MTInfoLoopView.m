//
//  MTInfoLoopView.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTInfoLoopView.h"
#import "MTInfoView.h"

@interface MTInfoLoopView ()

//声明两个infoView用于轮播器显示
@property (nonatomic, weak) MTInfoView *infoView1;
@property (nonatomic, weak) MTInfoView *infoView2;
//显示第几条数据的索引
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation MTInfoLoopView

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
    //infoView1
    MTInfoView *infoView1 = [[MTInfoView alloc] init];
    [self addSubview:infoView1];
    
    [infoView1 mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.bottom.top.offset(0);
        make.right.offset(-16);
    }];
    
    //infoView2
    MTInfoView *infoView2 = [[MTInfoView alloc] init];
    [self addSubview:infoView2];
    
    [infoView2 mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.equalTo(infoView1).offset(0);
        make.width.height.equalTo(infoView1);
        make.top.equalTo(infoView1.mas_bottom).offset(0);
    }];
    
    //给全局属性赋值
    _infoView1 = infoView1;
    _infoView2 = infoView2;
    
}

- (void)setDiscounts:(NSArray<MTInfoModel *> *)discounts
{
    _discounts = discounts;
    
    [self settingData];
    
    [self scroll];
    
}

//设置数据
- (void)settingData
{
    //显示当前数据
    _infoView1.infoModel = _discounts[_currentIndex];
    //显示吓一跳数据
    _infoView2.infoModel = _discounts[(_currentIndex + 1) % 7];

}

//滚动
- (void)scroll
{
    //延迟2秒滚动
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //动画的方式向上滚动
        [UIView animateWithDuration:0.5 animations:^{
            
            _infoView1.transform = CGAffineTransformMakeTranslation(0, -self.bounds.size.height);
            _infoView2.transform = CGAffineTransformMakeTranslation(0, -self.bounds.size.height);
            
        } completion:^(BOOL finished)
         {
            //索引加1,准备展示吓一跳数据
            _currentIndex = (_currentIndex + 1) % 7;
            
            [self settingData];
            
            //两个infoV都回到初始位置
            _infoView1.transform = CGAffineTransformIdentity;
            _infoView2.transform = CGAffineTransformIdentity;
            
            //递归进行无限滚动
            [self scroll];
    }];

    });
}

                   


@end

