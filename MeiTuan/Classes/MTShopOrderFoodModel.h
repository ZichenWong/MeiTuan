//
//  MTShopOrderFoodModel.h
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/3.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTShopOrderFoodModel : NSObject

//食品名
@property (nonatomic, copy) NSString *name;

+ (instancetype)shopOrderFoodWithDict:(NSDictionary *)dict;


@end
