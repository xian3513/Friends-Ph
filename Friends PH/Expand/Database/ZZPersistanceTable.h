//
//  ZZPersistanceTable.h
//  Friends PH
//
//  Created by xian on 15/12/28.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZZPersistanceRecord.h"
@class ZZPersistanceQueryCommand;

@protocol ZZPersistanceTableProtocol <NSObject>
@required

/**
 *  return the name of databse file, CTPersistanceDatabasePool will create CTDatabase by this string.
 *
 *  @return return the name of database file
 */
- (NSString *)databaseName;

/**
 *  the name of your table
 *
 *  @return return the name of your table
 */
- (NSString *)tableName;

/**
 *  column info with this table. If table not exists in database, CTPersistance will create a table based on the column info you provided
 *
 *  @return return the column info of your table
 */

- (NSDictionary *)columnInfo;

/**
 *  the name of the primary key.
 *
 *  @return return the name of the primary key.
 */
- (NSString *)primaryKeyName;

@optional
@end

@interface ZZPersistanceTable : NSObject

//- (NSArray *)fetch
@property(nonatomic,weak,readonly) ZZPersistanceTable<ZZPersistanceTableProtocol> *child;

@property(nonatomic,copy,readonly) NSString *queryCommandString;

/**
 *  insert a list of record
 *
 *  the record failed to insert will be included into error's userinfo, which key is kCTPersistanceErrorUserinfoKeyErrorRecord
 *
 *  if the record list is nil or empty, this method will return YES and error is nil.
 *
 *  @param recordList the list of record to insert
 *  @param error      error if fails
 *
 *  @return return YES if success
 *
 *  @warning if the record list is nil or empty, this method will return YES and error is nil.
 */
- (BOOL)insertRecordList:(NSArray <ZZPersistanceRecord *> *)recordList error:(NSError **)error;

/**
 *  insert a record
 *
 *  the record failed to insert will be included into error's userinfo, which key is kCTPersistanceErrorUserinfoKeyErrorRecord
 *
 *  if the record to insert is nil, this method will return YES and error is nil.
 *
 *  @param record the record to insert
 *  @param error  error if fails
 *
 *  @return return YES if success
 *
 *  @warning if the record is nil or empty, this method will return YES and error is nil.
 */
- (BOOL)insertRecord:(ZZPersistanceRecord *)record error:(NSError **)error;
@end
