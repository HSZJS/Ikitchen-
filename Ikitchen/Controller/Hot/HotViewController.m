//
//  HotViewController.m
//  Ikitchen
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HotViewController.h"
#import "define.h"
#import "AFNetworking.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HotModel.h"
#import "TopicModel.h"
#import "TopicCell.h"
#import "HotCell.h"
#import "FactoryUI.h"
#import "Carousel.h"
#import "UIButton+WebCache.h"
#import "CategoryViewController.h"
#import "PlayerViewController.h"

//#import "UIImageView+WebCache.h"
@interface HotViewController ()<UITableViewDataSource,UITableViewDelegate,playDelegte>
{
    UITableView * _tableView;
    
    
}
@property(nonatomic,strong) NSString * no;

//广告轮播的数组
@property(nonatomic,strong)NSMutableArray * cyclePlayImageArray;
//分类数组
@property(nonatomic,strong)NSMutableArray * categoryArray;
//TableView的数组
@property(nonatomic,strong)NSMutableArray * dataArray;

@end
@implementation HotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    [self createNavigation];
    [self creteTableView];
    [self loadData];
}
#pragma mark - 请求数据
-(void)loadData
{
    //初始化数组。给数组开辟0个字节空间
    self.cyclePlayImageArray = [NSMutableArray arrayWithCapacity:0];
    self.categoryArray = [NSMutableArray arrayWithCapacity:0];
    self.dataArray = [NSMutableArray arrayWithCapacity:0];
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"methodName": @"HomeIndex"};
    
    [manager POST:BASEURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0)
        {
            NSDictionary * mainDic = responseObject[@"data"];
            //广告轮播
            NSArray * cycleArray = mainDic[@"banner"][@"data"];
            for (NSDictionary * cycleDic in cycleArray)
            {
                [self.cyclePlayImageArray addObject:cycleDic[@"image"]];
            }
            
            //分类按钮
            self.categoryArray = mainDic[@"category"][@"data"];
            
            //tableView的数据
            NSMutableArray * hotArray = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray * newArray = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray * topicArray = [NSMutableArray arrayWithCapacity:0];
            NSMutableArray * rankArray = [NSMutableArray arrayWithCapacity:0];
            
            NSArray * mainArray = mainDic[@"data"];
            //热门推荐
            for (NSDictionary * hotDic in mainArray[0][@"data"])
            {
                HotModel * hotModel = [[HotModel alloc]init];
                [hotModel setValuesForKeysWithDictionary:hotDic];
                hotModel.image = hotDic[@"image"];
                hotModel.content =  hotDic[@"content"];
                hotModel.detail =  hotDic[@"detail"];
                hotModel.favorite =  hotDic[@"favorite"];
                hotModel.dataId =  hotDic[@"dataId"];
                hotModel.image =  hotDic[@"image"];
                hotModel.play =  hotDic[@"play"];
                hotModel.title =  hotDic[@"title"];
                hotModel.video =  hotDic[@"video"];
                [hotArray addObject:hotModel];
            }
            
            //新品推荐
            for (NSDictionary * newDic in mainArray[1][@"data"])
            {
                HotModel * newModel = [[HotModel alloc]init];
                [newModel setValuesForKeysWithDictionary:newDic];
                newModel.image = newDic[@"image"];
                
                newModel.content =  newDic[@"content"];
                newModel.detail = newDic[@"detail"];
                newModel.favorite =  newDic[@"favorite"];
                newModel.dataId =  newDic[@"dataId"];
                newModel.image =  newDic[@"image"];
                newModel.play = newDic[@"play"];
                newModel.title =  newDic[@"title"];
                newModel.video =  newDic[@"video"];
                [newArray addObject:newModel];
            }
            
            //排行榜
            for (NSDictionary * rankDic in mainArray[2][@"data"])
            {
                HotModel * rankModel = [[HotModel alloc]init];
                [rankModel setValuesForKeysWithDictionary:rankDic];
                rankModel.image = rankDic[@"image"];
                [rankArray addObject:rankModel];
            }
            
            //美食专题
            for (NSDictionary * topicDic in mainArray[3][@"data"])
            {
                TopicModel * topicModel = [[TopicModel alloc]init];
                [topicModel setValuesForKeysWithDictionary:topicDic];
                topicModel.image = topicDic[@"image"];
                [topicArray addObject:topicModel];
            }
            
            [self.dataArray addObject:hotArray];
            [self.dataArray addObject:newArray];
            [self.dataArray addObject:rankArray];
            [self.dataArray addObject:topicArray];
            
        }
        
        //刷新界面
        [self createTableHeaderView];
        [_tableView reloadData];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark - 创建tableviewHeaderView
-(void)createTableHeaderView
{
    //背景
    UIView * mainBgView = [FactoryUI createViewWithFrame:CGRectMake(0, 0, SCREEN_W, (SCREEN_H - 49)/ 4 + (SCREEN_H - 49) / 4 + 20 + 20)];
    mainBgView.backgroundColor = RGB(228, 229, 230);
    //第一部分,广告轮播
    Carousel * cyclePlayer = [[Carousel alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, (SCREEN_H - 49)/4)];
    //设置是否需要无限轮播
    cyclePlayer.infiniteLoop = YES;
    //设置pageControl的位置
    cyclePlayer.pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_RIGHT;
    //设置图片
    cyclePlayer.imageUrlArray = self.cyclePlayImageArray;
    [mainBgView addSubview:cyclePlayer];
    
    //第二部分,分类按钮
    
    UIView * categoryBgView = [FactoryUI createViewWithFrame:CGRectMake(0, cyclePlayer.frame.size.height + 10, SCREEN_W, (SCREEN_H - 49) / 4 + 20)];
    
    categoryBgView.backgroundColor = [UIColor cyanColor];
    [mainBgView addSubview:categoryBgView];
    
    for (int i = 0; i < self.categoryArray.count; i ++)
    {
        UIButton * categoryButton = [FactoryUI createButtonWithFrame:CGRectMake(30 + i % 4 * ((SCREEN_W - 30 * 5) / 4 + 30), 10 + i / 4 * ((SCREEN_W - 30 * 5) / 4 + 20), (SCREEN_W - 30 * 5) / 4, (SCREEN_W - 30 * 5) / 4) title:self.categoryArray[i][@"text"] titleColor:[UIColor darkGrayColor] imageName:nil backgroundImageName:nil target:self selector:@selector(categoryButtonClick:)];
        
        categoryButton.titleLabel.font = [UIFont systemFontOfSize:10];
        
        categoryButton.tag = 100 + i;
        [categoryBgView addSubview:categoryButton];
        
        //设置图片
        [categoryButton sd_setImageWithURL:[NSURL URLWithString:self.categoryArray[i][@"image"]] forState:UIControlStateNormal];
        
        //变换图片和标题的位置
        categoryButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        categoryButton.titleEdgeInsets = UIEdgeInsetsMake((SCREEN_W - 150) / 4 + 15, -150, 0, 0);
        
    }
    //设置成tableView的tableHeaderView
    _tableView.tableHeaderView = mainBgView;
    
    
    
    
    
    
    
}
-(void)creteTableView
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStyleGrouped];
    //设置代理
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    //去掉多余的线条
    _tableView.tableFooterView = [[UIView alloc]init];
    //去掉tableView所有的线条,第一种方法
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //第二种
    _tableView.separatorColor = [UIColor clearColor];
    
    
}
-(void)createNavigation
{
    
    //设置导航条颜色
    self.navigationController.navigationBar.barTintColor = [UIColor orangeColor];
    //设置导航条不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航条标题
    self.navigationItem.title = @"Hot";
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -实现tableView的代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * selectionArray = self.dataArray[section];
    return selectionArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 3)
    {
        TopicCell * cell = [tableView dequeueReusableCellWithIdentifier:@"TOPICID"];
        if (!cell)
        {
            cell = [[TopicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TOPICID"];
        }
        
        TopicModel * model = self.dataArray[indexPath.section][indexPath.row];
        
        [cell configUI:model];
        
        
        return cell;
    }
    
    HotCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell)
    {
        cell = [[HotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //设置代理
        cell.delegate  = self;
    }
    
    HotModel * model = self.dataArray[indexPath.section][indexPath.row];
    [cell configUI:model];
    
    
    return cell;
    
    
    
}
//设置header
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * bgHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    
    bgHeaderView.backgroundColor = [UIColor whiteColor];
    //左边label
    UILabel * leftLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 5, 100, 20) text:nil textColor:[UIColor orangeColor] font:[UIFont systemFontOfSize:12]];
    [bgHeaderView addSubview:leftLabel];
    //右边label
    UILabel * rightLabel = [FactoryUI createLabelWithFrame:CGRectMake(SCREEN_W -60, 5, 50, 20) text:@"更多>" textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:10]];
    [bgHeaderView addSubview:rightLabel];
    switch (section)
    {
        case 0:
            leftLabel.text = @"| 热门推荐";
            break;
        case 1:
            leftLabel.text = @"| 新品推荐";
            break;
        case 2:
            leftLabel.text = @"| 排行榜";
            break;
        case 3:
            leftLabel.text = @"| 主题推荐";
            break;
            
            
        default:
            break;
    }
    
    return bgHeaderView;
}
//设置row的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 3)
    {
        return 125;
    }
    return 155;
}
//设置header的高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
//点击跳转
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
}
#pragma mark - 按钮响应函数
-(void)categoryButtonClick:(UIButton *)button
{
    CategoryViewController * vc = [[CategoryViewController alloc]init];
    
    NSDictionary * dic = self.categoryArray[button.tag - 100];
    vc.dataId =   dic[@"id"];
    vc.navTitle = dic[@"text"];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -实现自定义的代理方法
-(void)deliverModel:(HotModel *)model
{
    HotModel * model1 = [[HotModel alloc]init];
    model1 = model;
    NSLog(@"jdfkjdkfjdskjf%@",model1.video);
    
    //实例化
    PlayerViewController * playerVC = [[PlayerViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
    //准备播放
    [playerVC.moviePlayer prepareToPlay];
    //开始播放
    [playerVC.moviePlayer play];
    //模态跳转
    [self presentViewController:playerVC animated:YES completion:nil];
    
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
