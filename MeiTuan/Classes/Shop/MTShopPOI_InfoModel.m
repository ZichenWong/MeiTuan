//
//  HMShopPOI_InfoModel.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTShopPOI_InfoModel.h"
#import "MTInfoModel.h"

@implementation MTShopPOI_InfoModel

+ (instancetype)shopPOI_infoWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

//如果模型属性比字典中key少,会来此方法,从而保证程序运行不崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //判断抛出的key是不是我们想要的
    if ([key isEqualToString:@"discounts2"])
    {
        //所有优惠信息
        NSArray *discountsArray = value;
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:discountsArray.count];
        for (NSDictionary *dict in discountsArray)
        {
            MTInfoModel *infoModel = [MTInfoModel infoWithDict:dict];
            [arrM addObject:infoModel];
        }
        //赋值给模型属性
        _discounts = arrM.copy;
    }    
}

@end
