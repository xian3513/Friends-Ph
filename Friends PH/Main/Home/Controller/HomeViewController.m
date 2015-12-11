//
//  HomeViewController.m
//  Friends PH
//
//  Created by xian on 15/12/9.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "MainTabBarViewController.h"

#import "HttpTool.h"
#import "NSObject+Method.h"
#import "BasicModel.h"
#import "ForecastModel.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabView;

@end

@implementation HomeViewController {
    CGFloat lastpace;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabView.tableHeaderView = [[HomeHeaderView alloc]init];

    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_yellow@2x"]];
    self.tabView.backgroundView = imageView;
    
    ForecastModel *model = [[ForecastModel alloc]init];
    [HttpTool getWeatherSuccess:^(id responseObject) {
       
        NSError *error;
        id resObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        // NSLog(@"responseObject:%@",resObject);
    
        ForecastModel *model1 = [[ForecastModel alloc]init];
        NSArray *arr = [resObject objectForKey:@"HeWeather data service 3.0"];
        // NSLog(@"weather:%@",[arr objectAtIndex:0]);
        model1 = [model1 modelTransferWithData:[arr objectAtIndex:0]];
        model1.basicModel = [model1.basicModel modelTransferWithData:model1.basic];
        
        NSLog(@"arr:%@, dict:%@ status:%@",model1.daily_forecast,model1.basicModel,model1.status);
        
    } failure:^(NSError *error) {
        
    }];
//        NSDictionary *dict = @{
//                               @"name" : @"Jack",
//                               @"icon" : @"lufy.png",
//                               @"age" : @20,
//                               @"height" : @"1.55",
//                               @"money" : @100.9,
//                               @"gay" : @"true",
//                               @"daily_forecast":@{@"t":@{@"o":@"oooo"}},
//                               @"basic":@[@"1234"]
//                               //   @"gay" : @"1"
//                               //   @"gay" : @"NO"
//                               };
//  model =  [self modelTransferWithData:dict modelClass:[ForecastModel class]];
//    NSLog(@"dict:%@, arr:%@",model.daily_forecast,model.basic);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    CGFloat delta = scrollView.contentOffset.y;
   // NSLog(@"lastpace:%f  delta:%f  = %f",lastpace,delta,lastpace-delta);
    if(delta <= 0){
        return;
    }
    if((lastpace - delta) > 0){
         [self.myTabBarController showAnimation];
      
    } else {
         [self.myTabBarController hideAnimation];
    }
    lastpace = delta;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(!decelerate) {
        [self.myTabBarController showAnimation];
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.myTabBarController showAnimation];
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text= @"aaa";
    return cell;
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
