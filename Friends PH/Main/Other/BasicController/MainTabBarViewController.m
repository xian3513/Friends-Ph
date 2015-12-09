//
//  MainTabBarViewController.m
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "TabbarView.h"
@interface MainTabBarViewController ()<TabbarViewDelegate,UITableViewDataSource>

@end

@implementation MainTabBarViewController

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
    // Do any additional setup after loading the view.
    // self.tabBar.selectedImageTintColor = [UIColor orangeColor];
    
    
    self.tabBar.hidden = YES;
    TabbarView *tabbar = [[TabbarView alloc]init];
    tabbar.delegate = self;
    tabbar.itemCount = 3;
//    tabbar.imageArray = @[[UIImage imageNamed:@"btn0"],[UIImage imageNamed:@"btn1"],[UIImage imageNamed:@"btnAdd0"],[UIImage imageNamed:@"btn2"],[UIImage imageNamed:@"btn3"],];
//    
//    tabbar.selectedImageArray = @[[UIImage imageNamed:@"btn0s"],[UIImage imageNamed:@"btn1s"],[UIImage imageNamed:@"btnAdd0"],[UIImage imageNamed:@"btn2s"],[UIImage imageNamed:@"btn3s"],];
    [tabbar showInView:self.view];
}

- (TabbarViewItem *)tabbar:(TabbarView *)tabbarView cellForRowAtIndex:(NSInteger)index {
    TabbarViewItem * item = [tabbarView dequeueReusableCellWithIdentifier:@"item"];
    
    item.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    return item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
