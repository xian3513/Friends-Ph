//
//  ZZBaseAPIManager.m
//  Friends PH
//
//  Created by xian on 16/1/5.
//  Copyright © 2016年 xian. All rights reserved.
//

#import "ZZBaseAPIManager.h"
#import "HttpTool.h"

@interface ZZBaseAPIManager()
@property(nonatomic,weak) id<ZZBaseAPIManagerDelegate> child;

@end
@implementation ZZBaseAPIManager

- (instancetype)init
{
    self = [super init];
   
    return self;
}

-(instancetype)initWithTargat:(id<APIManagerDelegate>)targat {
    if(self = [super init]){
        
        _delegate = targat;
        
        if ([self conformsToProtocol:@protocol(ZZBaseAPIManagerDelegate)]) {
            self.child = (id<ZZBaseAPIManagerDelegate>)self;
        }else {
            NSAssert(NO, @"子类必须要实现 ZZBaseAPIManagerDelegate 这个protocol。");
        }
    }
    return self;
}

- (void)requestWithAPIName:(NSString *)name {
    [HttpTool getWeatherSuccess:^(id responseObject) {
    
    } failure:^(NSError *error) {
    
    }];
}

@end
