//
//  TopicModel.m
//  Ikitchen
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

-(void)setValue:(id)value forKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.detal = value;
    }
    if ([key isEqualToString:@"id"]) {
        self.dataId = value;
    }

}
@end
