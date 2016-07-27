//
//  FoundRestaurantModel.h
//  Ikitchen
//
//  Created by qianfeng on 15/11/30.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapCommonObj.h>
@interface FoundRestaurantModel : NSObject
@property(nonatomic,strong) NSString * uid;
@property(nonatomic,strong) NSString * name;
@property(nonatomic,strong) NSString * type;
@property(nonatomic,strong) NSString * latitude;//经度
@property(nonatomic,strong) NSString * longtitude;//维度
@property(nonatomic,strong) NSString * address;

@end
