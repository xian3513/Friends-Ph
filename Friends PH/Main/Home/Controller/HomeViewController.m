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
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabView;

@end

@implementation HomeViewController {
  
    ForecastModel *_model;
    FonExchangeModel *_feModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    [self followScrollView:_tabView];
    _tabView.tableHeaderView = [[HomeHeaderView alloc]init];

    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_night_snow.jpg"]];
    self.tabView.backgroundView = imageView;
    
    _model = [[ForecastModel alloc]init];
   _feModel = [[FonExchangeModel alloc]init];
//    [HttpTool getForeignExchangeSuccess:^(id responseObject) {
//       
//        NSDictionary *dict = @{
//                               @"fromCurrency":@"retData.fromCurrency",
//                               @"toCurrency":@"retData.toCurrency"
//                               };
//        _feModel = [self modelTransferWithData:responseObject model:_feModel replacedKeyName:dict];
//        
//        NSLog(@"hahah  %@   %@",_feModel.fromCurrency,_feModel.toCurrency);
//    } failure:^(NSError *error) {
//        
//    }];
    [HttpTool getWeatherSuccess:^(id responseObject) {
       
        NSError *error;
        id resObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
      //  NSLog(@"responseObject:%@",resObject);
    
        NSArray *arr = [resObject objectForKey:@"HeWeather data service 3.0"];
         //NSLog(@"weather:%@",[arr objectAtIndex:0]);
        NSDictionary *replaceKey = @{
                                  // @"now":@"now.tmp",
                                   };
          NSDictionary *object = @{
               @"daily_forecast" : @"Daily_forecast",//  @“arrayName”：@“className”  如  @"ads" : [Ad class]
               @"hourly_forecast":@"Hourly_forecast",
              };
        _model = [self modelTransferWithData:[arr objectAtIndex:0] model:_model replacedKeyName:nil objectInArray:object];
        Hourly_forecast *hour = [_model.hourly_forecast objectAtIndex:0];
        NSLog(@"daily_forecast:%@, now:%@ status:%@",_model.daily_forecast,_model.now,_model.status);
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
