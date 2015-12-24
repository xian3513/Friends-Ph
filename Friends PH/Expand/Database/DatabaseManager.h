//
//  DatabaseManager.h
//  ChildFine
//
//  Created by xian on 15/11/6.
//  Copyright © 2015年 xian. All rights reserved.
//



                        // 目前是demo 方法 参数等，根据具体项目 修改

#import <Foundation/Foundation.h>
#import "FMDB.h"

@interface DatabaseManager : NSObject

+ (DatabaseManager *)manager; 
//+ (DatabaseManager *)shareDatabaseQueue;

/**
 *
 */
- (void)openDatabaseWithName:(NSString *)name;

/**
 *
 *  举例:
 *  NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,ID,NAME,AGE,ADDRESS];
 */
- (BOOL)createTableWithModel:(NSObject *)model;

- (BOOL)createTableWithSQL:(NSString *)sql;

/**
 *  批量添加数据
 *
 *  参数为model，插入的表名为model的类名，插入子段为model的 属性
 *  （缺点是 所有的属性都将被执行插入，属性为空，插入数据为空）
 */
- (BOOL)insertWithModels:(NSArray *)models Transaction:(BOOL)useTransaction;

- (BOOL)insertWithModel:(NSObject *)model;

- (BOOL)insertWithSQL:(NSString *)sql;



- (BOOL)updateWithSQL:(NSString *)sql;

- (BOOL)deleteWithSQL:(NSString *)sql;

/**
 *  NSString * sql = [NSString stringWithFormat:@"SELECT * FROM %@",TABLENAME];
 */
- (void)selectWithSQL:(NSString *)sql;
;
@end
