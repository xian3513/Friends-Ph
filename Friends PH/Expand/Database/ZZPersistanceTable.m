//
//  ZZPersistanceTable.m
//  Friends PH
//
//  Created by xian on 15/12/28.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "ZZPersistanceTable.h"
#import "ZZPersistanceQueryCommand.h"

@interface ZZPersistanceTable()
@property(nonatomic,weak) id<ZZPersistanceTableProtocol> child;

@property(nonatomic,strong,readwrite) ZZPersistanceQueryCommand *queryCommand;
@end

@implementation ZZPersistanceTable


///**
// *  execute sql in database of this table.
// *
// *  @param sqlString the sql string to be executed
// *  @param error     error if fails
// *
// *  @return return NO if fails
// */
//- (BOOL)executeSQL:(NSString *)sqlString error:(NSError **)error {
//    BOOL res = NO;
//    if ([_db open]) {
//        res = [_db executeUpdate:@""];
//        [_db close];
//        if (!res) {
//            NSLog(@"error when creating db table");
//        } else {
//            NSLog(@"success to creating db table");
//        }
//    }
//    
//    return res;
//}
//
///**
// *  fetch data with sql in database of this table
// *
// *  @param sqlString the sql string to fetch
// *  @param error     error if fails
// *
// *  @return return NO if fails
// */
//- (NSArray *)fetchWithSQL:(NSString *)sqlString error:(NSError **)error {
//
//}

- (BOOL)insertRecord:(ZZPersistanceRecord *)record error:(NSError *__autoreleasing *)error {

}

- (BOOL)insertRecordList:(NSArray<ZZPersistanceRecord *> *)recordList error:(NSError *__autoreleasing *)error {

}
#pragma mark - life cycle
-(instancetype)init {

    if(self = [super init]){
        if([self conformsToProtocol:@protocol(ZZPersistanceTableProtocol)]) {
            self.child = (ZZPersistanceTable<ZZPersistanceTableProtocol> *)self;
        }else {
            NSException *excrption = [NSException exceptionWithName:@"CTPersistanceTable init error" reason:@"the child class must conforms to protocol: <CTPersistanceTableProtocol>" userInfo:nil];
            @throw excrption;
        }
    }
    return self;
}

#pragma mark - getters and setters

- (ZZPersistanceQueryCommand *)queryCommand {
    if(!_queryCommand){
        _queryCommand = [[ZZPersistanceQueryCommand alloc]initWithDatabaseName:[self.child databaseName]];
    }
    return _queryCommand;
}



@end
