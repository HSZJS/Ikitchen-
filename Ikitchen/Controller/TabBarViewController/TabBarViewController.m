//
//  TabBarViewController.m
//  Ikitchen
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TabBarViewController.h"
//1热榜
#import "HotViewController.h"
//2排行榜
#import "BillboardViewController.h"
//3菜单分类
#import "MenuCatoryViewController.h"
//4发现餐馆
#import "FoundRestaurantViewController.h"
@interface TabBarViewController ()<UITabBarControllerDelegate>

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
    [self createTabBar];
}
-(void)configUI
{
 //配置item
    HotViewController * hotVC = [[HotViewController alloc]init];
    
    BillboardViewController * billVC = [[BillboardViewController alloc]init];
    
    MenuCatoryViewController * menuCatoryVC = [[MenuCatoryViewController alloc]init];
    FoundRestaurantViewController * foundRestaurantVC = [[FoundRestaurantViewController alloc]init];
    //配置navigation
    UINavigationController * hotNa = [[UINavigationController alloc]initWithRootViewController:hotVC];
    
    UINavigationController * billNa = [[UINavigationController alloc]initWithRootViewController:billVC];
    UINavigationController * menuCatoryNa = [[UINavigationController alloc]initWithRootViewController:menuCatoryVC];
    UINavigationController * foundRestaurantNa = [[UINavigationController alloc]initWithRootViewController:foundRestaurantVC];
    //统一添加navigation的背景颜色
    hotNa.view.backgroundColor = [UIColor orangeColor];
    //为navigation统一加名字
    hotNa.title = @"Hot";
    billNa.title = @"BillBoard";
    menuCatoryNa.title = @"MenuCatory";
    foundRestaurantNa.title = @"FoundRestaurant";
    //组装tabBar
    NSArray * controllers = @[hotNa,billNa,menuCatoryNa,foundRestaurantNa];
    self.viewControllers = controllers;
}
-(void)createTabBar
{
    NSArray * itemName = @[@"Hot",@"BillBoard",@"MenuCatory",@"FoundRes"];
    for (int i = 0; i<self.tabBar.items.count; i++) {
        UITabBarItem * item = self.tabBar.items[i];
        item =[item initWithTitle:itemName[i] image:nil selectedImage:nil];
    }
    //item  名称变黄
    [[UITabBarItem appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
