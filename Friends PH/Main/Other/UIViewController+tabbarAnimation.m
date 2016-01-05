//
//  UIViewController+tabbarAnimation.m
//  Friends PH
//
//  Created by xian on 16/1/4.
//  Copyright © 2016年 xian. All rights reserved.
//

#import "UIViewController+tabbarAnimation.h"
#import <objc/runtime.h>

const NSString *tabbarAnimationFollowScrollKey = @"tabbarAnimationFollowScrollKey";

@interface UIViewController()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *followScroll;
@end

@implementation UIViewController (tabbarAnimation)

- (void)setFollowScroll:(UIScrollView *)followScroll {
    objc_setAssociatedObject(self, &tabbarAnimationFollowScrollKey, followScroll, OBJC_ASSOCIATION_RETAIN);
}

- (UIScrollView *)followScroll {
    return objc_getAssociatedObject(self, &tabbarAnimationFollowScrollKey);
}

- (void)followScrollView:(UIScrollView *)scrollView {
    self.followScroll = scrollView;
    NSLog(@"foll:%@",self.followScroll);
    self.followScroll.delegate = self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
@end
