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
    
    return [self modelConfirmDataType:data model:model replacedKeyName:nil objectInArray:nil];
}

- (id)modelTransferWithData:(id)data model:(NSObject *)model objectInArray:(NSDictionary *)object {
    return [self modelTransferWithData:data model:model replacedKeyName:nil objectInArray:object];
}
- (id)modelTransferWithData:(id)data model:(NSObject *)model replacedKeyName:(NSDictionary *)name{
    return [self modelConfirmDataType:data model:model replacedKeyName:name objectInArray:nil];
}

- (id)modelTransferWithData:(id)data model:(NSObject *)model replacedKeyName:(NSDictionary *)name objectInArray:(NSDictionary *)object {
    
    return [self modelWithStringData:data model:model replacedKeyName:name objectInArray:object];
}
#pragma -mark inside method
- (id)modelConfirmDataType:(id)data model:(NSObject *)model replacedKeyName:(NSDictionary *)name objectInArray:(NSDictionary *)object {
    
    id tmp = nil;
    if([data isKindOfClass:[NSString class]]) {//如果数据是 nsstring类型
        
        NSString *str = (NSString *)data;
       tmp = [self modelWithStringData:str model:model replacedKeyName:name objectInArray:object];
        
    } else if ([data isKindOfClass:[NSDictionary class]]){
        
        tmp = [self modelWithStringData:data model:model replacedKeyName:name objectInArray:object];
    }
    
    return tmp;
}

- (id)modelWithStringData:(NSString *)data model:(NSObject *)model replacedKeyName:(NSDictionary *)name objectInArray:(NSDictionary *)object {
   
    if(object) {
        [[model class] mj_setupObjectClassInArray:^NSDictionary *{
            return object;
        }];
    }
   
    if(name){
        [[model class] mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return name;
        }];
    }
    return [[model class] mj_objectWithKeyValues:data];
}

@end
