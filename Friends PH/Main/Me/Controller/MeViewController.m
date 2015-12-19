//
//  MeViewController.m
//  Friends PH
//
//  Created by xian on 15/12/9.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "MeViewController.h"
#import "CommonMacros.h"
#import "BasicNavigationController.h"
#define headerViewHeight 200
@interface MeViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MeViewController {
    NSArray *_dataArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //self.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
  //  [self.MyNavigationController showCustomNavbarView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"wwva";
    _dataArray = @[@"我的APP",@"紧急求助电话",@"免费商家广告",@"关于我们"];
   // [self.MyNavigationController showCustomNavbarViewWithTitle:@"我的"];
    
    self.tabView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.backgroundImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, -headerViewHeight-20, self.view.width, headerViewHeight)];
    self.backgroundImageView.image =[UIImage imageNamed:@"car"];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.tabView.contentInset = UIEdgeInsetsMake(headerViewHeight, 0, 0, 0);
    self.tabView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.tabView addSubview:self.backgroundImageView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;//根据实际选择加不加上NavigationBarHight（44、64 或者没有导航条）
    if (y < -headerViewHeight) {
        CGRect frame =self.backgroundImageView.frame;
        frame.origin.y = y;
        frame.size.height =  -y;//contentMode = UIViewContentModeScaleAspectFill时，高度改变宽度也跟着改变
        self.backgroundImageView.frame = frame;
    }
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
#pragma mark - tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return TABBAR_HEIGHT;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footView = [UIView new];
    footView.backgroundColor = [UIColor clearColor];
    //    UILabel *logLab = [UILabel new];
    //    logLab.textAlignment = NSTextAlignmentCenter;
    //    logLab.text = @"贤思出品";
    //    logLab.textColor = [UIColor whiteColor];
    return footView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"meCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text= [_dataArray objectAtIndex:indexPath.row];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"sender;%@",sender);
 
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
     Get the new view controller using [segue destinationViewController].
     Pass the selected object to the new view controller.
}
*/

@end
