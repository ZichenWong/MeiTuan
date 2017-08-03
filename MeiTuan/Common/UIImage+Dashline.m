//
//  UIImage+Dashline.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "UIImage+Dashline.h"

@implementation UIImage (Dashline)

+ (instancetype)dashLineViewWithColor: (UIColor *)color
{
    //开始图片类型的上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(4, 1), NO, 0);
    
    //获取当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //画线
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, 4, 0);
    
    //设置为虚线样式
    CGFloat lengths[] = {2, 2};
    CGContextSetLineDash(ctx, 0, lengths, 2);
    
    //设置颜色
    [color set];
    
    //渲染
    CGContextStrokePath(ctx);
    
    //从图片类型上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图片类型上下文
    UIGraphicsEndImageContext();
    
    //返回虚线
    return image;

}

@end
