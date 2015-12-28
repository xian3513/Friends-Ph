//
//  ZZPersistanceDataBasePool.h
//  Friends PH
//
//  Created by xian on 15/12/28.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZZPersistanceDatabase;

@interface ZZPersistanceDatabasePool : NSObject

+(instancetype)sharedInstance;

- (ZZPersistanceDatabase *)databaseWithName:(NSString *)databaseName;

- (void)closeDatabaseWithName:(NSString *)databaseName;

- (void)closeAllDatabase;
@end


@interface ZZPersistanceDatabase : NSObject

@property(nonatomic,copy,readonly) NSString *databaseName;

- (instancetype)initWithDatabaseName:(NSString *)databaseName;

- (void)openDatabaseWithName:(NSString *)databaseName;

- (void)closeDatabase;
@end