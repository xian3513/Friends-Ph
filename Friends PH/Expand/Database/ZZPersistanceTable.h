//
//  ZZPersistanceTable.h
//  Friends PH
//
//  Created by xian on 15/12/28.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>
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


@end
