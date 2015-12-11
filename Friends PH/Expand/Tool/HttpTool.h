//
//  HttpTool.h
//  Friends PH
//
//  Created by xian on 15/12/11.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

+ (void)getWithUrl:(NSString *)URLString parameters:(NSDictionary *)parametters;
+ (void)getWeatherSuccess:(void (^)(id responseObject))success failure:(void(^)(NSError *error))failure;
@end
