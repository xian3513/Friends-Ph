//
//  NSObject+Method.h
//  Friends PH
//
//  Created by xian on 15/12/11.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
@interface NSObject (Method)

#pragma mark - return array
- (NSArray *)arrayTransferWithData:(id)data model:(NSObject *)model;

#pragma mark - return model
/**
 *  简单的key／value
 *
 */

- (id)modelTransferWithData:(id)data model:(NSObject *)model;//data 为 json或者 dict

/**
 *  model的key跟 数据key不同，需要映射或者多级映射
 *
 */
- (id)modelTransferWithData:(id)data model:(NSObject *)model replacedKeyName:(NSDictionary *)name;

/**
 *  数据的key是某个model的集合
 *
 */
- (id)modelTransferWithData:(id)data model:(NSObject *)model objectInArray:(NSDictionary *)object;

/**
 * 包涵上面两种情况
 *
 */
- (id)modelTransferWithData:(id)data model:(NSObject *)model replacedKeyName:(NSDictionary *)name objectInArray:(NSDictionary *)object;

@end
