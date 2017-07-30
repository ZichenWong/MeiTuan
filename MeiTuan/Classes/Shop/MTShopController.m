//
//  MTShopController.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/7/30.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTShopController.h"
#import "MTFoodDetailController.h"

@interface MTShopController ()

@end

@implementation MTShopController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.navBar.barTintColor = [UIColor redColor];
    
    self.navItem.title = @"66";
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    MTFoodDetailController *foodDetailVC = [[MTFoodDetailController alloc] init];
    
    [self.navigationController pushViewController:foodDetailVC animated:YES];
}

@end
