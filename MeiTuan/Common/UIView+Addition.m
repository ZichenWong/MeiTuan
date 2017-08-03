//
//  UIView+Addition.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/2.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

- (UIViewController *)viewController
{
    //寻找下一个响应者对象
    UIResponder *responder = [self nextResponder];
    
    //只要有响应者就进入循环
    while (responder)
    {
        //如果相应对象是控制器就直接返回
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)responder;
        }
        
        //如果不是,就继续寻找下一个响应者
        responder = [responder nextResponder];
    }
    
    
    return nil;
}

@end
