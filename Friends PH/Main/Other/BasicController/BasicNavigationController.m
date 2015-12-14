//
//  BasicViewController.m
//  ChildFine
//
//  Created by xian on 15/11/2.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "BasicNavigationController.h"
#import "CommonMacros.h"
#import "Masonry.h"

@implementation CostomNavbarView {

    UILabel *_titleLab;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame              = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        self.backgroundColor    = [UIColor clearColor];
        
        [self viewLayout];
    }
    return self;
}

- (void)viewLayout {

    //mainView
    self.contentView        = [UIView new];
    self.leftView           = [UIView new];
    self.rightView          = [UIView new];
    
//    self.contentView.backgroundColor = [UIColor yellowColor];
//    self.leftView.backgroundColor = [UIColor purpleColor];
//    self.rightView.backgroundColor = [UIColor blueColor];
    
    [self addSubview:self.contentView];
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.bottom.equalTo(self);
        make.leading.equalTo(self.leftView.mas_trailing).offset(5);
        make.trailing.equalTo(self.rightView.mas_leading).offset(-5);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.leading.bottom.equalTo(self);
        make.width.mas_equalTo(44);
    }];
    
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.bottom.equalTo(self);
        make.top.equalTo(self.contentView);
        make.width.mas_equalTo(44);
    }];
    
    //contentView
    _titleLab                   = [UILabel new];
    _titleLab.textAlignment     = NSTextAlignmentCenter;
    _titleLab.textColor         = [UIColor whiteColor];
    _titleLab.font              = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_titleLab];
    
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.bottom.equalTo(self.contentView).offset(0);
    }];
}

- (void)setTitle:(NSString *)title {
    _titleLab.text = title;
}
@end

@interface BasicNavigationController ()

@end

@implementation BasicNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"themeBackground"] forBarMetrics:UIBarMetricsDefault];
   
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
     self.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor blackColor]};
}

- (CostomNavbarView *)showCustomNavbarViewWithTitle:(NSString *)title {
    CostomNavbarView *navbarView = [[CostomNavbarView alloc]init];
    [self.view addSubview:navbarView];
    navbarView.title = title;
    self.navigationBar.hidden = YES;
    return navbarView;
}

- (void)addPromptAndQRCodeOnRightBarButtonItemWith:(UIViewController *)target action:(SEL)action {
    
    NSInteger width = 14;
    NSInteger height = 16;
    UIViewController *addTarget = target;
    SEL addAction = action;
    if(!target){
        addTarget = self;
        addAction = @selector(addButtonPress:);
    }
    UIButton *QRbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [QRbutton setBackgroundImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
    QRbutton.frame = CGRectMake(0, 0, 16, 16);
    
    UIButton *promptButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [promptButton setBackgroundImage:[UIImage imageNamed:@"bell"] forState:UIControlStateNormal];
    promptButton.frame = CGRectMake(20, 0, width, height);
    [QRbutton addTarget:addTarget action:addAction forControlEvents:UIControlEventTouchUpInside];
    [promptButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    QRbutton.tag = 0;
    promptButton.tag = 1;
    
    
    UIBarButtonItem* fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil]; fixedSpace.width = 20;
    
    UIBarButtonItem *QRCodeItem = [[UIBarButtonItem alloc] initWithCustomView:QRbutton];
    UIBarButtonItem *promptItem = [[UIBarButtonItem alloc] initWithCustomView:promptButton];
    NSArray *buttonArray = [[NSArray alloc] initWithObjects:QRCodeItem,fixedSpace,promptItem, nil];
    self.topViewController.navigationItem.rightBarButtonItems = buttonArray;
    
}

- (void)addHeaderIconOrChildPlusImageOnLeftbarButtonItem:(BOOL)isHeader {
    
    UIImageView *imageView = [[UIImageView alloc]init];
    if(isHeader){
        imageView.image = [UIImage imageNamed:@"default_head"];
        imageView.layer.cornerRadius = 18;
        imageView.layer.borderWidth = 2;
        imageView.layer.borderColor = RGBA(137, 232, 211, 1).CGColor;
        imageView.layer.masksToBounds = YES;
        imageView.frame = CGRectMake(0, 0, 38, 38);
    }else {
        UIImage *image = [UIImage imageNamed:@"childPlus"];
        imageView.image = image;
        imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        //NSLog(@"size.width:%f",image.size.width);
    }
    
    UIBarButtonItem *iconImage = [[UIBarButtonItem alloc]initWithCustomView:imageView];
    //self.navigationItem.leftBarButtonItem = iconImage;
    self.topViewController.navigationItem.leftBarButtonItem = iconImage;
}
- (void)addNavigationBackItem {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    
    backBtn.frame = CGRectMake(0, 0, 10, 18);
    [backBtn addTarget:self action:@selector(popBack:) forControlEvents:UIControlEventTouchUpInside];
    
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        self.topViewController.navigationItem.leftBarButtonItem = item;
}

- (void)popBack:(UIBarButtonItem *)item {
    [self popViewControllerAnimated:YES];
}

- (void)cancelNavigationBarTranslucentAndBottomBlackLine {
    //去掉nav默认的透明效果 这个属性会导致代码编写的view的y值 差64
    self.navigationBar.translucent = NO;
    //修改navBar底部的黑线
    if ([self.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        NSArray *list=self.navigationBar.subviews;
        for (id obj in list) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView=(UIImageView *)obj;
                NSArray *list2=imageView.subviews;
                for (id obj2 in list2) {
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        UIImageView *imageView2=(UIImageView *)obj2;
                        imageView2.hidden=YES;
                    }
                }
            }
        }
    }
}

- (void)addButtonPress:(UIButton *)sender {
    
    if(sender.tag == 0){//二维码扫描
    
    }
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

@implementation UIViewController (MyNavigationController)

-(BasicNavigationController *)MyNavigationController
{
    if ([self.navigationController isMemberOfClass:[BasicNavigationController class]]) {
        return (BasicNavigationController*)self.navigationController;
    }
    return nil;
}
@end
