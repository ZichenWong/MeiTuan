//
//  MTShopOrderController.m
//  MeiTuan
//
//  Created by 王子晨 on 2017/7/31.
//  Copyright © 2017年 wzc. All rights reserved.
//

#import "MTShopOrderController.h"
#import "MTShopOrderFoodModel.h"
#import "MTShopOrderCategoryModel.h"
#import "MTShopOrderCategoryCell.h"

@interface MTShopOrderController ()<UITableViewDelegate, UITableViewDataSource>
//食品类型tableView
@property (nonatomic, weak) UITableView *categoryTableView;

@end
//食物类型cellID
static NSString *categoryCellID = @"categoryCellID";
//食物cellID
static NSString *foodCellID = @"foodCellID";

@implementation MTShopOrderController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    //界面搭建
    [self setupUI];
}

//界面搭建
- (void)setupUI
{
    [self settingCategoryTableView];
    
    [self settingFoodTableView];

}

//类型表格
- (void)settingCategoryTableView
{
    //新建tableView
    UITableView *categoryTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:categoryTableView];
    //设置约束
    [categoryTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.left.top.bottom.offset(0);
        make.width.offset(100);
    }];
    //给全局属性赋值
    _categoryTableView = categoryTableView;
    //设置代理
    categoryTableView.delegate = self;
    categoryTableView.dataSource = self;
    //注册cell
    [categoryTableView registerClass:[MTShopOrderCategoryCell class] forCellReuseIdentifier:categoryCellID];
    //设置行高
    categoryTableView.rowHeight = 60;
    //隐藏分割线
    categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

//食物表格
- (void)settingFoodTableView
{
    //新建tableView
    UITableView *foodTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:foodTableView];
    //设置约束
    [foodTableView mas_makeConstraints:^(MASConstraintMaker *make)
     {
        make.top.right.bottom.offset(0);
        make.left.equalTo(_categoryTableView.mas_right).offset(0);
    }];
    //设置代理
    foodTableView.delegate = self;
    foodTableView.dataSource = self;
    
    //注册cell
    [foodTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:foodCellID];
}

//返回多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (tableView == _categoryTableView)
    {   //类型表格
        return 1;
    }
    //食物表格
    return _categoryData.count;
}

//返回每组多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _categoryTableView)
    {
        //类型行数
        return _categoryData.count;
    }
    //食物行数
    return _categoryData[section].spus.count;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //返回类型表格cell
    if (tableView == _categoryTableView)
    {
        MTShopOrderCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:categoryCellID forIndexPath:indexPath];

        cell.categoryModel = _categoryData[indexPath.row];
        
        //返回cell
        return cell;
        
    }
    
    //返回食物表格cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:foodCellID forIndexPath:indexPath];
    //取一组食物模型
    MTShopOrderCategoryModel *categoryModel = _categoryData[indexPath.section];
    //取一个食物模型
    MTShopOrderFoodModel *foodModel = categoryModel.spus[indexPath.row];
    
    cell.textLabel.text = foodModel.name;
    
    return cell;
}


@end
