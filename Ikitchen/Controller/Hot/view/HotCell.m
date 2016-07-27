//
//  HotCell.m
//  Ikitchen
//
//  Created by qianfeng on 15/12/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HotCell.h"
#import "HotModel.h"
#import "FactoryUI.h"
#import "define.h"
#import "UIImageView+WebCache.h"
@interface HotCell()
//全局变量用来传值
@property(nonatomic,strong)HotModel * model;

@end

@implementation HotCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self makeUI];
    }
    
    return self;
}

-(void)makeUI
{
    _mainImageView = [FactoryUI createImageViewWithFrame:CGRectMake(10, 0, SCREEN_W - 20, 150) imageName:nil];
    [self.contentView addSubview:_mainImageView];
    
    _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, _mainImageView.frame.size.height - 40, SCREEN_W - 20, 20) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:13]];
    [_mainImageView addSubview:_titleLabel];
    
    UIView * subView = [FactoryUI createViewWithFrame:CGRectMake(0, _mainImageView.frame.size.height -20, _mainImageView.frame.size.width, 20)];
    //设置灰色背景
    subView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    [_mainImageView addSubview:subView];
    
    _detailLabel = [FactoryUI createLabelWithFrame:CGRectMake(10, 0, 150, 20) text:nil textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:11]];
    [subView addSubview:_detailLabel];
    //创建播放按钮
    UIButton * playButton = [FactoryUI createButtonWithFrame:CGRectMake(0, 0, 50, 50) title:nil titleColor:nil imageName:@"love_Play_Icon" backgroundImageName:nil target:self selector:@selector(playButtonClick)];
    playButton.center = _mainImageView.center;
    [self.contentView addSubview:playButton];
   


}
//赋值
-(void)configUI:(HotModel *)model
{
     _model = model;

    [_mainImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    
    _titleLabel.text = model.title;
        _detailLabel.text = model.detail;

}
-(void)playButtonClick
{
//判断代理对象有没有响应方法
    if ([_delegate respondsToSelector:@selector(deliverModel:)])
    {
        [_delegate deliverModel:_model];
    }



}

- (void)awakeFromNib {
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

  
}

@end
