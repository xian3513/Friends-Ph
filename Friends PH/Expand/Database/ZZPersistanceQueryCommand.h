//
//  ZZPersistanceQueryCommand.h
//  Friends PH
//
//  Created by xian on 15/12/28.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZPersistanceQueryCommand : NSObject

- (instancetype)initWithDatabaseName:(NSString *)databaseName;

- (ZZPersistanceQueryCommand *)insertTable:(NSString *)tableName withDataList:(NSArray *)dataList;

/**
 *  execute SQL with sqlString
 *
 *  @param error error if fails
 *
 *  @return return NO if fails, and YES for success
 */
- (BOOL)executeWithError:(NSError **)error;

/**
 *  fetch data with sqlString
 *
 *  @param error error if fails
 *
 *  @return return fetched data list
 */
- (NSArray <NSDictionary *> *)fetchWithError:(NSError **)error;
@end
