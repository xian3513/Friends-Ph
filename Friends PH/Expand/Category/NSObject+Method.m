//
//  NSObject+Method.m
//  Friends PH
//
//  Created by xian on 15/12/11.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "NSObject+Method.h"


@implementation NSObject (Method)

#pragma -mark outside method
- (NSArray *)arrayTransferWithData:(id)data model:(NSObject *)model{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    
    return arr;
}

- (id)modelTransferWithData:(id)data model:(NSObject *)model{
    
    return [self modelConfirmDataType:data model:model mapTpye:nil];
}

- (id)modelTransferWithData:(id)data model:(NSObject *)model mapTpye:(NSDictionary *)map {
    return [self modelConfirmDataType:data model:model mapTpye:map];
}
#pragma -mark inside method
- (id)modelConfirmDataType:(id)data model:(NSObject *)model mapTpye:(NSDictionary *)map{
    
    id tmp = nil;
    if([data isKindOfClass:[NSString class]]) {//如果数据是 nsstring类型
        NSString *str = (NSString *)data;
       tmp = [self modelWithStringData:str model:model mapTpye:map];
    } else if ([data isKindOfClass:[NSDictionary class]]){
        tmp = [self modelWithStringData:data model:model mapTpye:map];
    }
    
    return tmp;
}



- (id)modelWithStringData:(NSString *)data model:(NSObject *)model mapTpye:(NSDictionary *)map{
    [[model class] mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"daily_forecast" : @"Daily_forecast",
                 // @"statuses" : [Status class],
                 //  @"ads" : @"Ad"
                 // @"ads" : [Ad class]
                 };
    }];
    if(map){
        [[model class] mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return map;
        }];
    }
    return [[model class] mj_objectWithKeyValues:data];
}

@end
