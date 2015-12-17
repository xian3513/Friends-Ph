//
//  BasicViewController.h
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    CostomNavbarButtonTypeShare
}CostomNavbarButtonType;
@interface CostomNavbarView : UIView
@property(nonatomic,strong) NSString *title;

@property(nonatomic,strong) UIView *contentView;
@property(nonatomic,strong) UIView *leftView;
@property(nonatomic,strong) UIView *rightView;

- (void)addRightButtonTarget:(id)target action:(SEL)action buttonType:(CostomNavbarButtonType)buttonType;
- (void)addLeftButtonTarget:(id)target action:(SEL)action buttonType:(CostomNavbarButtonType)buttonType;
@end


@interface BasicNavigationController : UINavigationController

- (CostomNavbarView *)showCustomNavbarViewWithTitle:(NSString *)title;
- (void)hiddenCustomNavbarView;
- (void)showCustomNavbarView;
- (void)customNavbarAddRightbuttonTarget:(id)target action:(SEL)action buttonType:(CostomNavbarButtonType)buttonType;
- (void)customNavbarAddLeftbuttonTarget:(id)target action:(SEL)action buttonType:(CostomNavbarButtonType)buttonType;
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