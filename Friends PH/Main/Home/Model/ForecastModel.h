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


@interface ForecastModel : NSObject

@property(nonatomic,strong) NSArray *daily_forecast;
@property(nonatomic,strong) Basic *basicModel;
@property(nonatomic,strong) NSDictionary *basic;
@property(nonatomic,copy) NSString *status;
@end
