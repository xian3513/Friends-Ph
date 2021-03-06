//
//  MainTabBarViewController.m
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "BasicTabBarViewController.h"
#import "UIView+Frame.h"
#import "BasicViewController.h"

@interface BasicTabBarViewController ()<TabbarViewDelegate,UINavigationControllerDelegate>

@end

@implementation BasicTabBarViewController {
    NSArray *_itemTitleArr;
    
    BOOL _tabbarDown;
    CGFloat _tabbarAnimationInterval;
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

- (void)hideAnimation {
    if(!_tabbarDown) {
       // NSLog(@"%@",NSStringFromSelector(_cmd));
        [UIView animateWithDuration:_tabbarAnimationInterval animations:^(){
            CGRect rect = CGRectMake(self.tabbarView.left, self.view.height, self.tabbarView.width, self.tabbarView.height);
            self.tabBar.frame = rect;
        } completion:^(BOOL finish){
            _tabbarDown = YES;
        }];
    }
  
}

- (void)showAnimation {
    if(_tabbarDown){
        // NSLog(@"%@",NSStringFromSelector(_cmd));
        [UIView animateWithDuration:_tabbarAnimationInterval animations:^(){
            CGRect rect = CGRectMake(self.tabbarView.left, self.view.height-49, self.tabbarView.width, self.tabbarView.height);
            self.tabBar.frame = rect;
        } completion:^(BOOL finish){
            _tabbarDown = NO;
        }];
    }
}



 //实现nav的delegate方法，完成 hidecustomBarWhenpushed 效果
//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated {
//    //NSLog(@"viewController%d  nav:%d",viewController.hidesCustomBottomBarWhenPushed,viewController.navigationController.hidesCustomBottomBarWhenPushed);
//#warning 考虑 一个 nav ＋一个tabbar＋n个viewcontroller情况
//    //此算法只适合 一个tabbar＋n个navbarController的情况
//    // 只有当nav的 hides属性为真  viewcontroller属性为假时 隐藏tabbar
////     BOOL isHidden = navigationController.hidesCustomBottomBarWhenPushed^viewController.hidesCustomBottomBarWhenPushed;
////    if(isHidden){
////    
////    }
//    self.tabbarView.hidden = navigationController.hidesCustomBottomBarWhenPushed^viewController.hidesCustomBottomBarWhenPushed;
//
//}
//- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
////    BOOL isHidden = navigationController.hidesCustomBottomBarWhenPushed^viewController.hidesCustomBottomBarWhenPushed;
////    if(isHidden){
////        self.tabbarView.hidden = isHidden;
////    }
////    if([navigationController isKindOfClass:[BasicNavigationController class]]){
////        BasicNavigationController *nav = (BasicNavigationController *)navigationController;
////        [nav aaNav:nav controller:viewController];
////    }
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *bgImg = [[UIImage alloc] init];
    [self.tabBar setBackgroundImage:bgImg];
    [self.tabBar setShadowImage:bgImg];
    
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] == NSOrderedAscending) {
        [[UITabBar appearance] setSelectedImageTintColor:[UIColor colorWithRed:127.0/255.0 green:186.0/255.0 blue:235.0/255.0 alpha:1.0]];
        [[UITabBar appearance] setSelectionIndicatorImage:bgImg];
    }
    
    _itemTitleArr = @[@"关注/focus",@"讯息/news",@"我的/me"];
    _tabbarAnimationInterval = 0.15;
    self.tabbarView = [[TabbarView alloc]init];
    self.tabbarView.delegate = self;
    self.tabbarView.itemCount = 3;
    [self.tabbarView showInView:self.tabBar];
    
     //实现nav的delegate方法，完成 hidecustomBarWhenpushed 效果
//    for(id controller in self.viewControllers){
//        
//        if([[controller class] isSubclassOfClass:[UINavigationController class]]){
//            UINavigationController *nav = controller;
//            if(!nav.delegate){
//                nav.delegate = self;
//            }
//        }else if ([[controller class] isSubclassOfClass:[UIViewController class]]){
//            UIViewController *vc = controller;
//            vc.navigationController.delegate = self;
//        }
//    }
    
    
    

        //上面两个是清除item的背景色跟选中背景色
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 49)];
//    view.backgroundColor = [UIColor colorWithRed:0.1 green:0.6 blue:0.5 alpha:0.2];
//    [self.tabBarController.tabBar addSubview:view];
//    view.userInteractionEnabled = YES;
//    self.tabBarController.tabBar.backgroundColor = [UIColor clearColor];
}

- (TabbarViewItem *)tabbar:(TabbarView *)tabbarView cellForRowAtIndex:(NSInteger)index {
    TabbarViewItem * item = [tabbarView dequeueReusableCellWithIdentifier:@"item"];
    item.itemTitle = _itemTitleArr[index];
    item.backgroundColor = [UIColor colorWithRed:MAX(MIN(0.5, arc4random()%255/255.0), 0.2) green:MAX(MIN(0.5, arc4random()%255/255.0), 0.2) blue:MAX(MIN(0.5, arc4random()%255/255.0), 0.2) alpha:0.7];
    return item;
}

- (void)tabbar:(TabbarView *)tabbarView didSeletedRowAtIndex:(NSInteger)index {
    NSLog(@"index:%ld",index);
    self.selectedIndex = index;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
