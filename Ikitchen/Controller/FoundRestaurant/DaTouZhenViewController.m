//
//  DaTouZhenViewController.m
//  Ikitchen
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DaTouZhenViewController.h"
#import "FoundRestaurantViewController.h"
#import "define.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchAPI.h>
@interface DaTouZhenViewController ()<MAMapViewDelegate,AMapSearchDelegate,UIActionSheetDelegate>
{
    MAMapView * _mapView;
    AMapSearchAPI * _search;
    
}


@end

@implementation DaTouZhenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createMap];
   

}

-(void)createMap
{
    
    //配置用户key
    [MAMapServices sharedServices].apiKey = MapKey;
    
    _mapView = [[MAMapView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    [self.view addSubview:_mapView];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MAPointAnnotation * pointAnnotation1 = [[MAPointAnnotation alloc]init];
    double jing = [self.jing doubleValue];
    double wei = [self.wei doubleValue];
    pointAnnotation1.coordinate = CLLocationCoordinate2DMake(jing, wei);
    pointAnnotation1.title = self.name;
    pointAnnotation1.subtitle = self.address;
    [_mapView addAnnotation:pointAnnotation1];

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
