//
//  HotModel.m
//  Ikitchen
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HotModel.h"

@implementation HotModel
//防崩溃大法
-(void)setValue:(id)value forKey:(NSString *)key
{
    //修改一些和系统重复的字段
    if ([key isEqualToString:@"id"]) {
        self.dataId = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.detail = value;
    }
    

}
@end
