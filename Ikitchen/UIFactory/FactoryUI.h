//
//  FactoryUI.h
//  Ikitchen
//
//  Created by qianfeng on 15/12/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface FactoryUI : NSObject
//工厂,实际是大批量生产零件的地方,如果映射到代码中,其实就是将一类控件的所有属性用一个静态方法做一个总结归纳,方便统一修改
//UIView
+(UIView *)createViewWithFrame:(CGRect)frame;
//UILabel
+(UILabel *)createLabelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;
//UIButton
+(UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor imageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName target:(id)target selector:(SEL)selector;
//UIImageView
+(UIImageView *)createImageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName;
//UITextField
+(UITextField *)createTextFieldwithFrame:(CGRect)frame text:(NSString *)text placeHolder:(NSString *)placeHolder;










@end
