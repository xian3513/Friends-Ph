//
//  CommonMacros.m
//  ChildFine
//
//  Created by xian on 15/11/3.
//  Copyright © 2015年 xian. All rights reserved.
//


//CommonMacros.h


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define TABBAR_HEIGHT self.tabBarController.tabBar.frame.size.height

#define CONTENT_HEIGHT (SCREEN_HEIGHT - 44 - 20 - TABBAR_HEIGHT)

//Log utils marco
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
