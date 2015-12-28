//
//  BasicViewController.m
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "BasicViewController.h"

typedef enum {
    BasicAnimationTypeNone,
    BasicAnimationTypeNavgationGradient,
    BasicAnimationTypeTabbarMove
}BasicAnimationType;

@interface BasicViewController ()<UIScrollViewDelegate>

@end

@implementation BasicViewController {
    
    CGFloat lastpace;
    BasicAnimationType animationType;
    UIScrollView *_scrollView;
}

#pragma mark - lift cycle method
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]){
    
    }
    return self;
}

- (instancetype)init {
    if(self = [super init]){
      
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    animationType = BasicAnimationTypeNone;
    self.view.backgroundColor = RGBA(235, 235, 235, 1);
}

- (void)setBackgroundView:(UIView *)backgroundView {
    
    _backgroundView = backgroundView;
    
    if(backgroundView) {
        _backgroundView.frame = self.view.bounds;
        [self.view addSubview:_backgroundView];
        [self.view sendSubviewToBack:_backgroundView];
    }
    
}
#pragma mark - tabbarAnimation method
- (void)followScrollView:(UIScrollView *)scrollableView {
    animationType = BasicAnimationTypeTabbarMove;
    _scrollView = scrollableView;
    _scrollView.delegate = self;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat delta = scrollView.contentOffset.y;
     NSLog(@"lastpace:%f  delta:%f  = %f",lastpace,delta,lastpace-delta);
    if(delta <= 0){
        return;
    }
    if((lastpace - delta) > 0){
           [self.myTabBarController showAnimation];
        
    } else {
         [self.myTabBarController hideAnimation];
    }
    lastpace = delta;

    switch (animationType) {
        case BasicAnimationTypeTabbarMove:{
            
            break;
        }
        case BasicAnimationTypeNavgationGradient:{
         break;
        }
        default:
            break;
    }
    
//    if(_gradientOffset){
//        
//        CGFloat value = MAX(0.1, 1-delta/_gradientOffset);
//        self.MyNavigationController.navigationBar.barTintColor = [UIColor colorWithRed:value green:value blue:value alpha:1];
//    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(!decelerate) {
       // NSLog(@"%@",NSStringFromSelector(_cmd));
        [self.myTabBarController showAnimation];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.myTabBarController showAnimation];
    //NSLog(@"%@",NSStringFromSelector(_cmd));
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

@implementation UIViewController (MyController)

-(BasicTabBarViewController *)myTabBarController
{
    if ([self.tabBarController isMemberOfClass:[BasicTabBarViewController class]]) {
        return (BasicTabBarViewController*)self.tabBarController;
    }
    return nil;
}

-(BasicNavigationController *)MyNavigationController
{
    if ([self.navigationController isMemberOfClass:[BasicNavigationController class]]) {
        return (BasicNavigationController*)self.navigationController;
    }
    return nil;
}
@end
