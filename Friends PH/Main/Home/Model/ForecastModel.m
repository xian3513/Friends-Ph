//
//  ForecastModel.m
//  Friends PH
//
//  Created by xian on 15/12/11.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "ForecastModel.h"

@implementation ForecastModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.basic = [[Basic alloc]init];
        self.now = [Now new];
        //self.daily_forecast = [[Daily_forecast alloc]init];
    }
    return self;
}
@end

@implementation Basic

@end
@implementation Daily_forecast

@end
@implementation Hourly_forecast

@end
@implementation Now

@end