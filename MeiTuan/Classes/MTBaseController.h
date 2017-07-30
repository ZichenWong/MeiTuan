//
//  MTBaseController.h
//  MeiTuan
//
//  Created by 王子晨 on 2017/7/30.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MTNavigationBar;

@interface MTBaseController : UIViewController
//导航条
@property (nonatomic, strong, readonly) MTNavigationBar *navBar;
//导航标签
@property (nonatomic, strong, readonly) UINavigationItem *navItem;

@end
