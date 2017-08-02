//
//  MTInfoLoopView.h
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTInfoModel;
@interface MTInfoLoopView : UIView

//所有优惠信息的数据
@property (nonatomic, strong) NSArray<MTInfoModel *> *discounts;

@end
