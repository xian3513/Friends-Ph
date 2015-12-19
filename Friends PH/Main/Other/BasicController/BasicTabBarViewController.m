//
//  MainTabBarViewController.m
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "BasicTabBarViewController.h"
#import "UIView+Frame.h"


@interface BasicTabBarViewController ()<TabbarViewDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) NSMutableArray *customBottomBarNameArray;
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

- (void)showCustomBottomBar {
    self.tabbarView.hidden = NO;
}

- (void)hideCustomBottomBar {
    self.tabbarView.hidden = YES;
}

- (void)hideAnimation {
    if(!_tabbarDown) {
       // NSLog(@"%@",NSStringFromSelector(_cmd));
        [UIView animateWithDuration:_tabbarAnimationInterval animations:^(){
            CGRect rect = CGRectMake(self.tabbarView.left, self.view.height, self.tabbarView.width, self.tabbarView.height);
            self.tabbarView.frame = rect;
        } completion:^(BOOL finish){
            _tabbarDown = YES;
        }];
    }
  
}

- (void)showAnimation {
    if(_tabbarDown){
       //  NSLog(@"%@",NSStringFromSelector(_cmd));
        [UIView animateWithDuration:_tabbarAnimationInterval animations:^(){
            CGRect rect = CGRectMake(self.tabbarView.left, self.view.height-49, self.tabbarView.width, self.tabbarView.height);
            self.tabbarView.frame = rect;
        } completion:^(BOOL finish){
            _tabbarDown = NO;
        }];
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"willShowViewController：%@",viewController);

        if([self.customBottomBarNameArray containsObject:[viewController class]]){
            self.tabbarView.hidden = NO;
        }else {
            self.tabbarView.hidden = YES;
        }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.tabBar.selectedImageTintColor = [UIColor orangeColor];
    _itemTitleArr = @[@"关注/focus",@"讯息/news",@"我的/me"];
    _tabbarAnimationInterval = 0.15;
    self.tabBar.hidden = YES;
    self.tabbarView = [[TabbarView alloc]init];
    self.tabbarView.delegate = self;
    self.tabbarView.itemCount = 3;
    [self.tabbarView showInView:self.view];
    
    if(!self.customBottomBarNameArray) {
        self.customBottomBarNameArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    for(UINavigationController *nav in self.viewControllers){
        
        [self.customBottomBarNameArray addObject:[nav.topViewController class]];
    }
        self.selectedIndex = 0;
        UINavigationController *navController = self.selectedViewController;
        if(!navController.delegate) {
            navController.delegate = self;
        }
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
    //实现nav的delegate方法，完成 hidecustomBarWhenpushed 效果
    UINavigationController *navController = self.selectedViewController;
    if(!navController.delegate) {
        navController.delegate = self;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation UIViewController (MyTabBarController)


-(BasicTabBarViewController *)myTabBarController
{
    if ([self.tabBarController isMemberOfClass:[BasicTabBarViewController class]]) {
        return (BasicTabBarViewController*)self.tabBarController;
    }
    return nil;
}
@end
