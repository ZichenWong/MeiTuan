//
//  HMShopPOI_InfoModel.h
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MTInfoModel;
@interface MTShopPOI_InfoModel : NSObject

//头部视图背景图片
@property (nonatomic, copy) NSString *poi_back_pic_url;
//头像
@property (nonatomic, copy) NSString *pic_url;
//店名
@property (nonatomic, copy) NSString *name;
//商家公告
@property (nonatomic, copy) NSString *bulletin;

//优惠信息
@property (nonatomic, strong) NSArray<MTInfoModel *> *discounts;


+ (instancetype)shopPOI_infoWithDict:(NSDictionary *)dict;

@end
