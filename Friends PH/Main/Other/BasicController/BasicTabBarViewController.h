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

- (void)showAnimation;
- (void)hideAnimation;
@end

@interface UIViewController (MyTabBarController)

@property (readonly,nonatomic)BasicTabBarViewController *myTabBarController;

@end