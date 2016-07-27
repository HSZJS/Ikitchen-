//
//  TopicCell.m
//  Ikitchen
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//
#import "define.h"
#import "TopicCell.h"
#import "FactoryUI.h"
#import "UIImageView+WebCache.h"
#import "TopicModel.h"
@interface TopicCell()

@property(nonatomic,strong)TopicModel  * model;
@end
@implementation TopicCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }

    return self;
}
-(void)makeUI
{
    _mainImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 0, SCREEN_H - 20, 80) imageName:nil];
    [self.contentView addSubview:_mainImageView];
    
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _mainImageView.frame.size.height + 5, SCREEN_W - 20, 15) text:nil textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:13]];
    [self.contentView addSubview:_titleLabel];
    _detailLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _titleLabel.frame.size.height + _titleLabel.frame.origin.y + 5, SCREEN_W - 20, 15) text:nil textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:11]];
    [self.contentView addSubview:_detailLabel];

}
-(void)configUI:(TopicModel *)model
{
     _model = model;
    NSLog(@"%@",model.detal);
    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    NSLog(@"%@",model.image);
    _titleLabel.text = model.title;
    _detailLabel.text = model.detal;

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
