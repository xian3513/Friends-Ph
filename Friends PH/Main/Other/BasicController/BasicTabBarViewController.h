//
//  MainTabBarViewController.h
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarView.h"

@interface BasicTabBarViewController : UITabBarController

@property(nonatomic,strong) TabbarView *tabbarView;
@property(nonatomic) BOOL hidesCustomBottomBarWhenPushed;
- (void)showAnimation;
- (void)hideAnimation;

- (void)showCustomBottomBar;
- (void)hideCustomBottomBar;
@end

@interface UIViewController (MyTabBarController)

@property (readonly,nonatomic)BasicTabBarViewController *myTabBarController;

@end