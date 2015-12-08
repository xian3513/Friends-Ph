//
//  MainTabBarViewController.m
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "TabbarView.h"
@interface MainTabBarViewController ()<TabbarViewDelegat>

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
     self.tabBar.selectedImageTintColor = [UIColor orangeColor];
    
    
    self.tabBar.hidden = YES;
    TabbarView *tabbar = [[TabbarView alloc]init];
    tabbar.delegate = self;
    tabbar.imageArray = @[[UIImage imageNamed:@"btn0"],[UIImage imageNamed:@"btn1"],[UIImage imageNamed:@"btnAdd0"],[UIImage imageNamed:@"btn2"],[UIImage imageNamed:@"btn3"],];
    
    tabbar.selectedImageArray = @[[UIImage imageNamed:@"btn0s"],[UIImage imageNamed:@"btn1s"],[UIImage imageNamed:@"btnAdd0"],[UIImage imageNamed:@"btn2s"],[UIImage imageNamed:@"btn3s"],];
    [tabbar showInView:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
