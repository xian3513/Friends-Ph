//
//  BasicViewController.h
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicNavigationController : UINavigationController

/**
 *  添加返回按钮
 */
- (void)addNavigationBackItem;

/**
 *  删除navigationBar下端的黑线
 */
- (void)cancelNavigationBarTranslucentAndBottomBlackLine;

/**
 *  添加navigationbar左上角的图像图标
 */
- (void)addHeaderIconOrChildPlusImageOnLeftbarButtonItem:(BOOL)isHeader;

/**
 *  添加nav右上角两个按钮
 */
- (void)addPromptAndQRCodeOnRightBarButtonItemWith:(UIViewController *)target action:(SEL)action;

@end

@interface UIViewController (MyNavigationController)

@property (readonly,nonatomic)BasicNavigationController *MyNavigationController;

@end