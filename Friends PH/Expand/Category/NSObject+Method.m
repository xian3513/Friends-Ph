//
//  NSObject+Method.m
//  Friends PH
//
//  Created by xian on 15/12/11.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "NSObject+Method.h"
#import "MJExtension.h"

@implementation NSObject (Method)

- (NSArray *)arrayTransferWithData:(id)data model:(NSObject *)model{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    
    return arr;
}

- (id)modelTransferWithData:(id)data {
    
    return [self modelConfirmDataType:data];
}

- (id)modelConfirmDataType:(id)data {
    
    id tmp = nil;
    if([data isKindOfClass:[NSString class]]) {//如果数据是 nsstring类型
        NSString *str = (NSString *)data;
       tmp = [self modelWithStringData:str];
    } else if ([data isKindOfClass:[NSDictionary class]]){
        tmp = [self modelWithStringData:data];
    }
    
    return tmp;
}



- (id)modelWithStringData:(NSString *)data {
    //[self initModel:[[self class] mj_objectWithKeyValues:data]];
    return [[self class] mj_objectWithKeyValues:data];
}

@end
