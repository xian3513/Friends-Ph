//
//  TabbarView.h
//  KKHDome
//
//  Created by xian on 15/11/30.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TabbarViewDelegate;
@class TabbarViewItem;

@interface TabbarView : UIView

@property(nonatomic,assign) NSInteger itemCount;
@property(nonatomic,weak) id<TabbarViewDelegate> delegate;


- (void)updateRedIconWithShow:(BOOL)isShow atIndex:(NSInteger)index;

- (void)showInView:(UIView *)view;

- (TabbarViewItem *)dequeueReusableCellWithIdentifier:(NSString *)idfentifier;

@end

@protocol TabbarViewDelegate <NSObject>

@required

- (TabbarViewItem *)tabbar:(TabbarView *)tabbarView cellForRowAtIndex:(NSInteger)index;
@optional
- (void)tabbar:(TabbarView *)tabbarView didSeletedRowAtIndex:(NSInteger)index;

@end

@interface  TabbarViewItem: UIView
@property(nonatomic,copy) NSString *itemTitle;
- (void)highlighted;
- (void)normal;
@end