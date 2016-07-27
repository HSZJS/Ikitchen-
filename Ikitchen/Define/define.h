//
//  define.h
//  Ikitchen
//
//  Created by qianfeng on 15/11/27.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef Ikitchen_define_h
#define Ikitchen_define_h
//添加全局的头文件
#import <UIKit/UIKit.h>
//数据请求

#define HotUrl @"";
/**categoryURL*/
#define MenuCatoryUrl @"https://www.xiachufang.com/page/app-category"
/**榜单介绍*/
#define BillBoardUrl @"https://www.xiachufang.com/page/top-list/"
/**高德地图key*/
#define MapKey @"c0d98dce3d07942f3a2c28aec4f54fdd"
//添加全局的宏定义
//宽度
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
//高度
#define SCREEN_H ([UIScreen mainScreen].bounds.size.height - 64)
//设置颜色
#define RGB(r,g,b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]

//数据请求接口
#define BASEURL @"http://api.izhangchu.com:/"

#endif
