//
//  MTShopDetailAnimator.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/8/3.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTShopDetailAnimator.h"

@interface MTShopDetailAnimator () <UIViewControllerAnimatedTransitioning>



@end

@implementation MTShopDetailAnimator

//modal时调用
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

//dismiss时调用
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}


//返回转场动画时间
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

//modal和dismiss时都会调用此方法
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    //获取到要去的界面
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    //获取来源控制器的view
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    //获取到容器视图
    UIView *containerView = [transitionContext containerView];
    
    //把modal出来的界面添加到容器视图中
    [containerView addSubview:toView];
    
    //转场完成后告诉系统转场完成
    [transitionContext completeTransition:YES];
}

@end
