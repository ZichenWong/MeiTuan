//
//  MTShopOrderController.h
//  MeiTuan
//
//  Created by 王子晨 on 2017/7/31.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTShopOrderCategoryModel;
@interface MTShopOrderController : UIViewController

//接收全部食品模型数据
@property (nonatomic, strong) NSArray<MTShopOrderCategoryModel *> *categoryData;

@end
