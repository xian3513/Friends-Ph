//
//  UIViewController+TabbarAnimation.m
//  Friends PH
//
//  Created by xian on 15/12/28.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "BasicViewController.h"
#import "BasicTabBarViewController.h"
#import "UIViewController+TabbarAnimation.h"

@implementation UIViewController (TabbarAnimation)

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(!decelerate) {
        [self.myTabBarController showAnimation];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.myTabBarController showAnimation];
    // NSLog(@"%@",NSStringFromSelector(_cmd));
}
@end
