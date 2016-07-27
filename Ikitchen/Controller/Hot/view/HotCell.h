//
//  HotCell.h
//  Ikitchen
//
//  Created by qianfeng on 15/12/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotModel.h"
//自定义代理方法
@protocol playDelegte <NSObject>

-(void)deliverModel :(HotModel *)model;

@end


@interface HotCell : UITableViewCell
{
    UIImageView * _mainImageView;
    UILabel * _titleLabel;
    UILabel * _detailLabel;


}
//声明一个id指针,让他指向遵循自定义协议的对象
@property(nonatomic,weak)id<playDelegte>delegate;
-(void)configUI:(HotModel *)model;

@end
