//
//  BasicViewController.h
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonMacros.h"
#import "BasicNavigationController.h"
#import "BasicTabBarViewController.h"
@interface BasicViewController : UIViewController

#pragma mark - navbarGradientColor

@property(nonatomic) CGFloat gradientOffset; //defult 0 means unGradient

#pragma mark - tabbarAnimation method

- (void)followScrollView:(UIScrollView *)scrollableView;

@property(nonatomic,strong) UIView *backgroundView;
@end

@interface UIViewController (MyController)
@property(nonatomic) BOOL hidesCustomBottomBarWhenPushed;
@property (readonly,nonatomic)BasicNavigationController *MyNavigationController;
@property (readonly,nonatomic,strong)BasicTabBarViewController *myTabBarController;

@end
