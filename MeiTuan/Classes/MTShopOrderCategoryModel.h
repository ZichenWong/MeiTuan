//
//  MTShopOrderCategoryModel.h
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/3.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTShopOrderFoodModel;
@interface MTShopOrderCategoryModel : NSObject

//食品类别
@property (nonatomic, copy) NSString *name;

//保存当前类别的所有食品
@property (nonatomic, strong) NSArray<MTShopOrderFoodModel *> *spus;

+ (instancetype)shopOrderCategoryWithDict:(NSDictionary *)dict;

@end
