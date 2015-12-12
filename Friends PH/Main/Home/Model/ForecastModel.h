//
//  ForecastModel.h
//  Friends PH
//
//  Created by xian on 15/12/11.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@end

@interface ForecastModel : NSObject

@property(nonatomic,strong) NSArray *daily_forecast;
@property(nonatomic,strong) Basic *basic;
@property(nonatomic,copy) NSString *testDate;
@property(nonatomic,copy) NSString *status;
@end
