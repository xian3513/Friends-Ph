//
//  NSObject+Method.m
//  Friends PH
//
//  Created by xian on 15/12/11.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "NSObject+Method.h"


@implementation NSObject (Method)

- (NSArray *)allParameters {
    unsigned int count;
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for(int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        [arr addObject:[NSString stringWithFormat:@"%s",property_getName(property)]];
        NSLog(@"attributes:%s",property_getAttributes(property));
        
    }
    free(properties);
    return arr;
}

#pragma -mark outside method
- (NSArray *)arrayTransferWithData:(id)data model:(NSObject *)model{
    NSMutableArray *arr = [[NSMutableArray alloc]initWithCapacity:0];
    
    return arr;
}

- (id)modelTransferWithData:(id)data {
    
    return [self modelConfirmDataType:data  replacedKeyName:nil objectInArray:nil];
}

- (id)modelTransferWithData:(id)data  objectInArray:(NSDictionary *)object {
    return [self modelTransferWithData:data  replacedKeyName:nil objectInArray:object];
}
- (id)modelTransferWithData:(id)data  replacedKeyName:(NSDictionary *)name{
    return [self modelConfirmDataType:data  replacedKeyName:name objectInArray:nil];
}

- (id)modelTransferWithData:(id)data replacedKeyName:(NSDictionary *)name objectInArray:(NSDictionary *)object {
    
    return [self modelWithStringData:data replacedKeyName:name objectInArray:object];
}
#pragma -mark inside method
- (id)modelConfirmDataType:(id)data replacedKeyName:(NSDictionary *)name objectInArray:(NSDictionary *)object {
    
//    id tmp = nil;
//    if([data isKindOfClass:[NSString class]]) {//如果数据是 nsstring类型
//        
//        NSString *str = (NSString *)data;
//       tmp = [self modelWithStringData:str model:model replacedKeyName:name objectInArray:object];
//        
//    } else if ([data isKindOfClass:[NSDictionary class]]){
//        
//        tmp = [self modelWithStringData:data model:model replacedKeyName:name objectInArray:object];
//    }
    
    return [self modelWithStringData:data replacedKeyName:name objectInArray:object];
}

- (id)modelWithStringData:(NSString *)data replacedKeyName:(NSDictionary *)name objectInArray:(NSDictionary *)object {
   
    if(object) {
        [[self class] mj_setupObjectClassInArray:^NSDictionary *{
            return object;
        }];
    }
   
    if(name){
        [[self class] mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return name;
        }];
    }
    return [[self class] mj_objectWithKeyValues:data];
}

@end
