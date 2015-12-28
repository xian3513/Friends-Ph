//
//  ZZPersistanceQueryCommand.m
//  Friends PH
//
//  Created by xian on 15/12/28.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "ZZPersistanceQueryCommand.h"

@interface ZZPersistanceQueryCommand()
@property(nonatomic,copy) NSString *databaseName;

@end
@implementation ZZPersistanceQueryCommand

- (instancetype)initWithDatabaseName:(NSString *)databaseName {
    if(self = [super init]){
        self.databaseName = databaseName;
    }
    return self;
}
@end
