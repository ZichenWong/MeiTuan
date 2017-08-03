//
//  MTShopOrderCategoryModel.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/3.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTShopOrderCategoryModel.h"
#import "MTShopOrderFoodModel.h"

@implementation MTShopOrderCategoryModel

+ (instancetype)shopOrderCategoryWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    
    if ([key isEqualToString:@"spus"])
    {
        NSMutableArray *foodsArrM = [NSMutableArray arrayWithCapacity:[value count]];
        for (NSDictionary *foodDict in value) {
            MTShopOrderFoodModel *foodModel = [MTShopOrderFoodModel shopOrderFoodWithDict:foodDict];
            [foodsArrM addObject:foodModel];
        }
        
        //赋值
        _spus = foodsArrM.copy;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
