//
//  MTInfoModel.h
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MTInfoModel : NSObject
//图标
@property (nonatomic, copy) NSString *icon_url;
//信息
@property (nonatomic, copy) NSString *info;

+ (instancetype)infoWithDict:(NSDictionary *)dict;

@end
