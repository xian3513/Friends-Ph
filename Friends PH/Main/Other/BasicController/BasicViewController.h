//
//  BasicViewController.h
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BasicViewController : UIViewController

#pragma mark - navbarGradientColor
@property(nonatomic) CGFloat gradientOffset; //defult 0 means unGradient
#pragma mark - tabbarAnimation method
- (void)followScrollView:(UIScrollView *)scrollableView;
@end
