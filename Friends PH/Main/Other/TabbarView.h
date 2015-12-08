//
//  TabbarView.h
//  KKHDome
//
//  Created by xian on 15/11/30.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabbarViewDelegat;

@interface TabbarView : UIView

@property(nonatomic,strong) NSArray *imageArray;
@property(nonatomic,strong) NSArray *selectedImageArray;
@property(nonatomic,weak) id<TabbarViewDelegat>delegate;


- (void)updateRedIconWithShow:(BOOL)isShow atIndex:(NSInteger)index;
- (void)showInView:(UIView *)view;
@end

@protocol TabbarViewDelegat <NSObject>

@optional
- (void)tabbar:(TabbarView *)tabbarView didSeletedRowAtIndex:(NSInteger)index;

@end

