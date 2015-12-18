//
//  CommonMacros.m
//  ChildFine
//
//  Created by xian on 15/11/3.
//  Copyright © 2015年 xian. All rights reserved.
//


//CommonMacros.h
#import "UIView+Frame.h"
#import "ColorTransformRGB.h"
#import "Masonry.h"
#import "NSString+Method.h"

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define TABBAR_HEIGHT self.tabBarController.tabBar.frame.size.height

#define NAVBAR_HEIGHT 64
#define CONTENT_HEIGHT (SCREEN_HEIGHT - 44 - 20 - TABBAR_HEIGHT)

//Log utils marco
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]



#define T_RGB(cor) [[ColorTransformRGB alloc]init].color(cor)  //依赖于 ColorTransformRGB.h