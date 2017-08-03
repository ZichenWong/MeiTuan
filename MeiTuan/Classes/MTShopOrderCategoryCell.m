//
//  MTShopOrderCategoryCell.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/3.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTShopOrderCategoryCell.h"
#import "MTShopOrderCategoryModel.h"

@implementation MTShopOrderCategoryCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    self.textLabel.numberOfLines = 2;
    
    self.textLabel.font = [UIFont systemFontOfSize:12];
    
    self.backgroundColor = [UIColor colorWithHex:0xefefef];
    
    //给cell设置一个虚线
    UIView *bgLineView = [[UIView alloc] init];
    bgLineView.backgroundColor = [UIColor colorWithPatternImage:[UIImage dashLineViewWithColor:[UIColor blackColor]]];
    self.backgroundView = bgLineView;
    
    [bgLineView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.right.offset(0);
        make.height.offset(1);
        make.bottom.offset(0);
    }];
    
    //设置选中的视图样式
    UIView *selectedBgView = [UIView new];
    selectedBgView.backgroundColor = [UIColor whiteColor];
    
    self.selectedBackgroundView = selectedBgView;
    
    //添加小黄条
    UIView *lineYellowView = [UIView new];
    lineYellowView.backgroundColor = [UIColor primaryYellowColor];
    [selectedBgView addSubview:lineYellowView];
    
    [lineYellowView mas_makeConstraints:^(MASConstraintMaker *make)
    {
        make.left.centerY.offset(0);
        make.width.offset(4);
        make.height.offset(44);
    }];
}

- (void)setCategoryModel:(MTShopOrderCategoryModel *)categoryModel
{
    _categoryModel = categoryModel;
    
    self.textLabel.text = categoryModel.name;
}



@end
