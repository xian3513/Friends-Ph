//
//  HomeViewController.m
//  Friends PH
//
//  Created by xian on 15/12/9.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "BasicTabBarViewController.h"
#import "BasicNavigationController.h"
#import "HttpTool.h"
#import "NSObject+Method.h"
#import "ForecastModel.h"
#import "FonExchangeModel.h"
#import "Home_Job_TableViewCell.h"
#import "JobViewController.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabView;

@end

@implementation HomeViewController {
  
    ForecastModel *_model;
    FonExchangeModel *_feModel;
    HomeHeaderView *_headerView;
    
}

#pragma mark - lift cycle method

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    _model = [[ForecastModel alloc]init];
    _feModel = [[FonExchangeModel alloc]init];
    _headerView = [[HomeHeaderView alloc]init];
    [self followScrollView:_tabView];
    _tabView.tableHeaderView = _headerView;
   
    self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_night_snow.jpg"]];
    
     [self.MyNavigationController showCustomNavbarViewWithTitle:@"天气"];
    [self.MyNavigationController customNavbarAddRightbuttonTarget:self action:@selector(navRightButtonPress:) buttonType:CostomNavbarButtonTypeShare];
    [self http];
    
}

- (void)navRightButtonPress:(UIButton *)sender {

}

- (void)http {
//        [HttpTool getForeignExchangeSuccess:^(id responseObject) {
//    
//            NSDictionary *dict = @{
//                                   @"fromCurrency":@"retData.fromCurrency",
//                                   @"toCurrency":@"retData.toCurrency"
//                                   };
//            _feModel = [FonExchangeModel modelTransferWithData:responseObject replacedKeyName:dict];
//    
//            NSLog(@"hahah  %@   %@",_feModel.fromCurrency,_feModel);
//        } failure:^(NSError *error) {
//    
//        }];
    [HttpTool getWeatherSuccess:^(id responseObject) {

        NSString *key = @"HeWeather data service 3.0";
        NSError *error;
        id resObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
            NSArray *arr = [resObject objectForKey:key];
        if(arr){
            NSDictionary *replaceKey = @{
                                         @"now_cond_txt":@"now.cond.txt",
                                         @"basic_update_loc":@"basic.update.loc",
                                         };
            NSDictionary *object = @{
                                     @"daily_forecast" : @"Daily_forecast",//  @“arrayName”：@“className”  如  @"ads" : [Ad class]
                                     @"hourly_forecast":@"Hourly_forecast",
                                     };
            _model = [ForecastModel modelTransferWithData:[arr objectAtIndex:0] replacedKeyName:replaceKey objectInArray:object];
            [self viewUpdateData:_model];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

- (void)viewUpdateData:(ForecastModel *)model {
    _headerView.cond = _model.now_cond_txt;
    _headerView.temperature = _model.now.tmp;
    _headerView.updateTime = [NSString stringWithFormat:@"%0.0f分钟前发布",[self updateTimeInterval:_model.basic_update_loc]];
}

- (NSTimeInterval)updateTimeInterval:(NSString *)updateTime {
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate* date = [formater dateFromString:updateTime];
    
    return ([[NSDate date] timeIntervalSince1970] - [date timeIntervalSince1970])/60;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Home_Job_cell";
    Home_Job_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.nameLab.text = @"PHP开发";
    cell.addressLab.text = @"makati city";
    cell.treatmentLab.text = @"20000 ~ 30000";
    cell.updateTimeLab.text = @"2015-12-16";
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JobViewController *job = [[JobViewController alloc]init];
    [self.navigationController pushViewController:job animated:YES];
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
