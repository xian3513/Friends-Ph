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
