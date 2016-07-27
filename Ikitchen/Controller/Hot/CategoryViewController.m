//
//  CategoryViewController.m
//  Ikitchen
//
//  Created by qianfeng on 15/12/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CategoryViewController.h"
#import "define.h"
#import "HotCell.h"
#import "AFNetworking.h"
#import "PlayerViewController.h"
#import "MJRefresh.h"
#import "PlayerViewController.h"
@interface CategoryViewController ()<UITableViewDataSource,UITableViewDelegate,playDelegte>
{

    UITableView * _tableView;
    
    int _page;

}
//数据源
@property(nonatomic,strong)NSMutableArray * dataArray;

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //_page = 1;
    [self createTableView];
 
    [self autoRefresh];
}
-(void)autoRefresh
{
    [_tableView.header beginRefreshing];

//    停止刷新
            if (_page == 1)
            {
                [_tableView.header endRefreshing];
            }
            else
            {
                [_tableView.footer endRefreshing];
            }

}


#pragma mark - 创建tableView
-(void)createTableView
{
   _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.tableFooterView = [[UIView alloc]init];
    //自动刷新
    [_tableView.header beginRefreshing];
    
    //    停止刷新

    //下拉刷新和上拉加载
    _tableView.header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self refreshData];
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}
-(void)refreshData
{
    _page = 1;
    [self loadData];

}
-(void)loadMoreData
{
    _page++;
    [self loadData];

}
-(void)loadData
{
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    NSDictionary * dic = @{@"methodName": @"HomeSerial", @"page": [NSString stringWithFormat:@"%d",_page], @"serial_id": self.dataId, @"size": @"10"};
    
    [manager POST:BASEURL parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject[@"code"] intValue] == 0)
        {
            NSArray * array = responseObject[@"data"][@"data"];
            for (NSDictionary * categoryDic in array)
            {
                HotModel * model = [[HotModel alloc]init];
                /**
                 @property(nonatomic,copy)NSString * content;
                 @property(nonatomic,copy)NSString * detail;
                 @property(nonatomic,copy)NSString * favorite;
                 @property(nonatomic,copy)NSString * dataId;
                 @property(nonatomic,copy)NSString * image;
                 @property(nonatomic,copy)NSString * play;
                 @property(nonatomic,copy)NSString * title;
                 @property(nonatomic,copy)NSString * video;
                 */
                model.content = categoryDic[@"content"];
                model.detail = categoryDic[@"detail"];
                model.favorite = categoryDic[@"favorite"];
                model.dataId = categoryDic[@"dataId"];
                model.image = categoryDic[@"image"];
                model.play = categoryDic[@"play"];
                model.title = categoryDic[@"title"];
                model.video = categoryDic[@"video"];
                NSLog(@"%@",model.video);
                //[model setValuesForKeysWithDictionary:categoryDic];
                [self.dataArray addObject:model];
            }
        }
        if (_page == 1)
        {
            [_tableView.header endRefreshing];
        }
        else
        {
            [_tableView.footer endRefreshing];
        }

        //刷新数据
        NSLog(@"1");
        [_tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

#pragma mark - 实现tableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HotCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    if (!cell)
    {
        cell = [[HotCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
        cell.delegate = self;
    }
    HotModel * model = self.dataArray[indexPath.row];
    NSLog(@"我在这里");
    [cell configUI:model];
    
    //给cell添加一个动画
    [self addAnimationWithCell:cell];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 155;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //原来还没有写
    
}

//实现动画
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect newFrame = cell.frame;
    
    cell.frame = CGRectMake(0, cell.frame.size.height, cell.frame.size.width, cell.frame.size.height);
    [UIView animateWithDuration:0.7 animations:^{
        cell.frame = newFrame;
    }];
}

-(void)addAnimationWithCell:(UITableViewCell *)cell
{
    //设置cell的动画效果为一个3D效果
    //设置cell的frame的x和y值的初始值为0.1
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.7 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}
//添加点击事件
#pragma mark -实现播放方法
-(void)deliverModel:(HotModel *)model
{
 
    //实例化
    PlayerViewController * playerVC = [[PlayerViewController alloc]initWithContentURL:[NSURL URLWithString:model.video]];
    //准备播放
    [playerVC.moviePlayer prepareToPlay];
    //开始播放
    [playerVC.moviePlayer play];
    //模态跳转
    [self presentViewController:playerVC animated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 懒加载
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
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
