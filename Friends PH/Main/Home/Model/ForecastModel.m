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
        self.basicModel = [[Basic alloc]init];
    }
    return self;
}
@end

@implementation Basic

@end