//
//  UserHandler.m
//  Friends PH
//
//  Created by xian on 15/12/23.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "UserHandler.h"

static UserHandler *manager = nil;

@implementation UserHandler


#pragma mark - lift cycle method
//重写init 防止 外部 init出新对象
- (instancetype)init
{
    NSString *string = (NSString *)manager;
    if([string isKindOfClass:[NSString class]] && [string isEqualToString:@"UserHandler"]) {
        self = [super init];
        if (self) {
            
        }
        return self;
    } else {
        return nil;
    }
    
    
}
+ (UserHandler *)manager {
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        
        manager = (UserHandler *)@"UserHandler";
        manager = [[self alloc]init];
    });
    
    //防止子类继承本类，调用该方法
    NSString *classString = NSStringFromClass([self class]);
    if(![classString isEqualToString:@"UserHandler"]) {
        NSAssert(0, @"该类继承了单例类 :UserHandler");
    }
    return manager;
}

#pragma mark - database

-(DatabaseManager *)db {
    if(!_db){
        _db = [DatabaseManager manager];
    }
    return _db;
}
@end
