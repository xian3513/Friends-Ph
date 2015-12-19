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
    

     [self.MyNavigationController showCustomNavbarViewWithTitle:@"关注"];
    [self.MyNavigationController customNavbarAddRightbuttonTarget:self action:@selector(navRightButtonPress:) buttonType:CostomNavbarButtonTypeShare];
    [self http];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.MyNavigationController showCustomNavbarView];
    //[self.myTabBarController showCustomBottomBar];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
   // [self.myTabBarController hideCustomBottomBar];
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
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    for(Daily_forecast *tmp in model.daily_forecast){
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dict setObject:[self weekdayStringFromDate:[dateFormat dateFromString:tmp.date]] forKey:@"time"];
        [dict setObject:[tmp.cond objectForKey:@"txt_d"] forKey:@"cond_day"];
        [dict setObject:[NSString stringWithFormat:@"%@",[tmp.tmp objectForKey:@"max"]] forKey:@"tmp_max"];
       
        [dict setObject:[NSString stringWithFormat:@"%@",[tmp.tmp objectForKey:@"min"]] forKey:@"tmp_min"];
        [arr addObject:dict];
    }
    _headerView.daysInforArray = arr;
}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
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


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
     [self.MyNavigationController hiddenCustomNavbarView];
    UIViewController *viewController = segue.destinationViewController;
   // viewController.navigationController.navigationBarHidden = NO;
    if([viewController respondsToSelector:@selector(setJobID:)]){
        [viewController setValue:@"sdafda" forKey:@"jobID"];
    }
 
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


