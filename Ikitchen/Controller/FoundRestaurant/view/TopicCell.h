//
//  TopicCell.h
//  Ikitchen
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
@interface TopicCell : UITableViewCell
{
    UIImageView * _mainImageView;
    UILabel * _titleLabel;
    UILabel * _detailLabel;
}
-(void)configUI:(TopicModel *)model;
@end
