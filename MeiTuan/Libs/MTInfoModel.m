//
//  MTInfoModel.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTInfoModel.h"

@implementation MTInfoModel

+ (instancetype)infoWithDict:(NSDictionary *)dict
{
    id obj = [[self alloc] init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;

}

//如果模型属性比字典中key少,会来此方法,从而保证程序运行不崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


@end
