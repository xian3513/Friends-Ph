//
//  ForecastModel.h
//  Friends PH
//
//  Created by xian on 15/12/11.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "BasicModel.h"

@interface Basic : NSObject

@property(nonatomic,copy) NSString *city;
@property(nonatomic,copy) NSString *cnty;
@property(nonatomic) NSInteger _id;
@property(nonatomic,copy) NSString *lat;
@property(nonatomic,copy) NSString *lon;
@property(nonatomic,copy) NSDictionary *update;
@end

@interface Daily_forecast : NSObject
@property(nonatomic,copy) NSString *date;

//晴，多云...
@property(nonatomic,copy) NSString *cond_d;
@property(nonatomic,copy) NSString *cond_n;

@end

@interface Hourly_forecast : NSObject
@property(nonatomic,copy) NSString *date;
@property(nonatomic,copy) NSString *tmp;

@end
@interface Now : NSObject
//@property(nonatomic,copy) NSString *cond_txt;
@property(nonatomic,strong) NSDictionary *cond;
@property(nonatomic,copy) NSString *tmp;
@property(nonatomic,copy) NSString *fl;

@end
@interface ForecastModel : BasicModel

@property(nonatomic,strong) NSArray *daily_forecast;
@property(nonatomic,strong) NSArray *hourly_forecast;
@property(nonatomic,strong) Basic *basic;
@property(nonatomic,strong) Now * now;
@property(nonatomic,copy) NSString *now_cond_txt;
@property(nonatomic,copy) NSString *basic_update_loc;
@property(nonatomic,copy) NSString *status;
@end
