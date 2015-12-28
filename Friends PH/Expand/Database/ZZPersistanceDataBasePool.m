//
//  ZZPersistanceDataBasePool.m
//  Friends PH
//
//  Created by xian on 15/12/28.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "ZZPersistanceDatabasePool.h"
#import "FMDatabase.h"

@interface ZZPersistanceDatabasePool()
@property(nonatomic,strong) NSMutableDictionary *databaseList;
@end

@implementation ZZPersistanceDatabasePool

#pragma mark - life cycle
- (void)dealloc
{
    [self closeAllDatabase];
}

#pragma mark - public methods
+ (instancetype)sharedInstance {
    static ZZPersistanceDatabasePool *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ZZPersistanceDatabasePool alloc] init];
    });
    return instance;
}

- (ZZPersistanceDatabase *)databaseWithName:(NSString *)databaseName {
    if(databaseName == nil){
        return nil;
    }
    
    if (self.databaseList[databaseName] == nil) {
        self.databaseList[databaseName] = [[ZZPersistanceDatabase alloc]initWithDatabaseName:databaseName];
    }
    return self.databaseList[databaseName];
}


- (void)closeAllDatabase {
    [self.databaseList enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, ZZPersistanceDatabase *  _Nonnull obj, BOOL * _Nonnull stop) {
        if([obj isKindOfClass:[ZZPersistanceDatabase class]]){
            [obj closeDatabase];
        }
    
    }];
    
}

- (void)closeDatabaseWithName:(NSString *)databaseName {
    ZZPersistanceDatabase *database = self.databaseList[databaseName];
    if(databaseName){
        [database closeDatabase];
        [self.databaseList removeObjectForKey:databaseName];
    }
    
}

#pragma mark - getters and setters
- (NSMutableDictionary *)databaseList
{
    if (_databaseList == nil) {
        _databaseList = [[NSMutableDictionary alloc] init];
    }
    return _databaseList;
}

@end

#pragma mark - ZZPersistanceDatabase

@interface ZZPersistanceDatabase()

/**
 *  如果需要换数据库 修改这里
 */
@property(nonatomic,strong) FMDatabase *db;

@end

@implementation ZZPersistanceDatabase

- (instancetype)initWithDatabaseName:(NSString *)databaseName {
    if(self = [super init]){
        self.db = [FMDatabase databaseWithPath:[self documentPathWithName:databaseName]];
        _databaseName = databaseName;
        NSLog(@"open database success. Path:%@",[self documentPathWithName:databaseName]);
    }
    return self;
}

- (void)openDatabaseWithName:(NSString *)databaseName {
    self.db = [FMDatabase databaseWithPath:[self documentPathWithName:databaseName]];
    _databaseName = databaseName;
    NSLog(@"open database success. Path:%@",[self documentPathWithName:databaseName]);
}

- (void)closeDatabase {
    if(self.db){
        [self.db close];
    }
    NSLog(@"close database:%@ ",_databaseName);
    _databaseName = nil;
}

- (NSString *)documentPathWithName:(NSString *)fileName {
    //@"user.sqlite"
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [docsdir stringByAppendingPathComponent:fileName];
}
@end
