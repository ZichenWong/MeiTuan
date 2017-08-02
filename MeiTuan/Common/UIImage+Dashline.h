//
//  UIImage+Dashline.h
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Dashline)

//传过来颜色,返回该颜色的虚线
+ (instancetype)dashLineViewWithColor: (UIColor *)color;

@end
