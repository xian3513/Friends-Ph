//
//  AddressBookTable.h
//  Friends PH
//
//  Created by xian on 15/12/23.
//  Copyright © 2015年 xian. All rights reserved.
//





/**
 *
 *  为了保证 持久化层与业务层隔离，防止业务层随意修改数据库数据，
 * 
 *  做此数据隔离  “所有insert命令 的model都必须是该类的子类”
 *
 *
 *
 *
 *
 *
 *
 *
 *
 */
#import "DatabaseModel.h"

@interface AddressBookTable : DatabaseModel
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *tel;
@property(nonatomic,copy) NSString *age;
@end
