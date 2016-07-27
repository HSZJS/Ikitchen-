//
//  FoundRestaurantViewController.m
//  Ikitchen
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
/***
 
 功能:
 1.大头针标记附近的餐馆
 2.点击查看餐馆详情.
 3.查询餐馆
 
 **/
#import "FoundRestaurantViewController.h"
#import "define.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
#import "FoundRestaurantModel.h"
#import "TableViewController.h"
@interface FoundRestaurantViewController ()<MAMapViewDelegate,AMapSearchDelegate,UIActionSheetDelegate>
{
    MAMapView * _mapView;
    AMapSearchAPI * _search;

}
@property(nonatomic,strong)NSMutableArray * poiArray;//存放poi关键字
@property(nonatomic,strong)NSMutableArray * dataSource;//存放poiObject的对象

@property(nonatomic,strong)TableViewController * tableview;
@end

@implementation FoundRestaurantViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createNavigation];
    [self createPOI];
    [self createMap];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self createMap];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MAPointAnnotation * pointAnnotation1 = [[MAPointAnnotation alloc]init];
    pointAnnotation1.coordinate = CLLocationCoordinate2DMake(39.904989, 116.393711);
    
    pointAnnotation1.title = @"人民大会堂宴会厅";
    pointAnnotation1.subtitle = @"西长安街天安门广场";
    [_mapView addAnnotation:pointAnnotation1];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self createMap];

}

-(void)createNavigation
{
    self.title = @"FoundRestaurant";
    //设置导航条颜色
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    //设置导航条不透明
    self.navigationController.navigationBar.translucent = NO;
    //设置导航条标签标题
    self.navigationItem.title = @"FoundRestaurant";
    
}
-(void)createMap
{

    //配置用户key
    [MAMapServices sharedServices].apiKey = MapKey;

    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    
}
-(void)createPOI
{
    //poi
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"附近美食馆" style:UIBarButtonItemStyleDone target:self action:@selector(poiOnclick)];
}
-(void)poiOnclick
{
    UIActionSheet * actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles: nil];
    for (NSString * str in self.poiArray) {
        [actionSheet addButtonWithTitle:str];
    }
    [actionSheet showInView:self.view];

}

//实现poi搜索对应的回调函数
-(void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
    if (response.pois.count == 0) {
        return;
    }
    NSArray * itemArray = response.pois;
    
    [self.dataSource removeAllObjects];
    
    for ( AMapPOI * p in itemArray ) {
        FoundRestaurantModel * model = [[FoundRestaurantModel alloc]init];
        model.uid = p.uid;
        model.name = p.name;
        model.type = p.type;
        model.latitude = [NSString stringWithFormat:@"%f",p.location.latitude];//经度
        model.longtitude = [NSString stringWithFormat:@"%f",p.location.longitude];//维度
        model.address = p.address;
        [self.dataSource addObject:model];
    }
    self.tableview = [[TableViewController alloc]init];
    self.tableview.dataSource = self.dataSource;
    [self.navigationController pushViewController:self.tableview animated:NO];

}

#pragma -mark MAMapViewDelegate 大头针
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
        static NSString * pointResuseIndetifier = @"pointReuseIndetifier";
        MAPinAnnotationView * annotationView = (MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:pointResuseIndetifier];
        if (annotationView == nil) {
            annotationView = [[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:pointResuseIndetifier];
        }
        annotationView.canShowCallout = YES;
        annotationView.animatesDrop = YES;
        annotationView.draggable = YES;
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}



#pragma mark -UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0) {
        NSString * str = self.poiArray[buttonIndex -1];
     
        //发起poi搜索
        //初始化检索对象
        _search = [[AMapSearchAPI alloc]initWithSearchKey:MapKey Delegate:self];
        //构造请求对象
        AMapPlaceSearchRequest * poiRequest = [[AMapPlaceSearchRequest alloc]init];
        poiRequest.searchType = AMapSearchType_PlaceKeyword;
        poiRequest.keywords = str;
        poiRequest.city = @[@"北京"];
        poiRequest.requireExtension = YES;
        //发起poi搜索
        [_search AMapPlaceSearch:poiRequest];
    }
    else
    {
        NSLog(@"error");
    }
}

#pragma mark -懒加载
//存放标签的关键字的setter方法
-(NSMutableArray *)poiArray
{
    if (_poiArray == nil)
    {
        _poiArray = [NSMutableArray arrayWithObjects:@"中餐馆",@"西餐厅",@"韩国料理",@"日本餐厅",nil];
    }
 return _poiArray;
}
-(NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
