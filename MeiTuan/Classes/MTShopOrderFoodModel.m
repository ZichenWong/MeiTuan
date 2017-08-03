//
//  MTShopOrderFoodModel.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/3.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTShopOrderFoodModel.h"

@implementation MTShopOrderFoodModel

+ (instancetype)shopOrderFoodWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
