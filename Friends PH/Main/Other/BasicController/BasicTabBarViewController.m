//
//  MainTabBarViewController.m
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "BasicTabBarViewController.h"
#import "UIView+Frame.h"


@interface BasicTabBarViewController ()<TabbarViewDelegate>

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
        NSLog(@"%@",NSStringFromSelector(_cmd));
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
         NSLog(@"%@",NSStringFromSelector(_cmd));
        [UIView animateWithDuration:_tabbarAnimationInterval animations:^(){
            CGRect rect = CGRectMake(self.tabbarView.left, self.view.height-49, self.tabbarView.width, self.tabbarView.height);
            self.tabbarView.frame = rect;
        } completion:^(BOOL finish){
            _tabbarDown = NO;
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // self.tabBar.selectedImageTintColor = [UIColor orangeColor];
    _itemTitleArr = @[@"天气",@"实景",@"我"];
    _tabbarAnimationInterval = 0.15;
    self.tabBar.hidden = YES;
    self.tabbarView = [[TabbarView alloc]init];
    self.tabbarView.delegate = self;
    self.tabbarView.itemCount = 3;
    [self.tabbarView showInView:self.view];
}

- (TabbarViewItem *)tabbar:(TabbarView *)tabbarView cellForRowAtIndex:(NSInteger)index {
    TabbarViewItem * item = [tabbarView dequeueReusableCellWithIdentifier:@"item"];
    item.itemTitle = _itemTitleArr[index];
    item.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:0.4];
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

@implementation UIViewController (MyTabBarController)

-(BasicTabBarViewController *)myTabBarController
{
    if ([self.tabBarController isMemberOfClass:[BasicTabBarViewController class]]) {
        return (BasicTabBarViewController*)self.tabBarController;
    }
    return nil;
}
@end
