//
//  DatabaseManager.m
//  ChildFine
//
//  Created by xian on 15/11/6.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "DatabaseManager.h"
#import "NSObject+Method.h"
static DatabaseManager *manager = nil;

@interface DatabaseManager() {
    FMDatabase *_db;
    FMDatabaseQueue * _queue;
    dispatch_queue_t _db_sync_queue;
}



@property (nonatomic,strong)FMDatabaseQueue * queue;
@end

@implementation DatabaseManager

#pragma mark - lift cycle method
+ (DatabaseManager *)manager {
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        
        manager = (DatabaseManager *)@"DatabaseManager";
        manager = [[self alloc]init];
        //初始化串行队列
        manager->_db_sync_queue = dispatch_queue_create("com.xian.test", NULL);
        //manager.queue = [FMDatabaseQueue databaseQueueWithPath:@"default.sqlite"];
    });
    
    //防止子类继承本类，调用该方法
    NSString *classString = NSStringFromClass([self class]);
    if(![classString isEqualToString:@"DatabaseManager"]) {
        NSAssert(0, @"继承了单例类 :DatabaseManager");
    }
    return manager;
}

//重写init 防止 外部 init出新对象
- (instancetype)init
{
    NSString *string = (NSString *)manager;
    if([string isKindOfClass:[NSString class]] && [string isEqualToString:@"DatabaseManager"]) {
        self = [super init];
        if (self) {
            
        }
        return self;
    } else {
        return nil;
    }
}

#pragma mark - SQLITE
- (void)openDatabaseWithName:(NSString *)name {
    //1.建立数据库只需要如下一行即可 , 当该文件不存在时，fmdb 会自己创建一个。
    //如果你传入的参数是空串：@“” ，则 fmdb 会在临时文件目录下创建这个数据库，
    //如果你传入的参数是 NULL，则它会建立一个在内存中的数据库
    _db = [FMDatabase databaseWithPath:[self documentPathWithName:name]];
    _queue = [FMDatabaseQueue databaseQueueWithPath:[self documentPathWithName:name]];
}

- (BOOL)createTableWithModel:(NSObject *)model {
//     NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,ID,NAME,AGE,ADDRESS];
    
    NSArray *parArray = [model allParameters];
    NSMutableString *mstr = [[NSMutableString alloc]initWithCapacity:0];
    [mstr appendFormat:@"CREATE TABLE IF NOT EXISTS '%@' ",NSStringFromClass([model class])];
    for(NSString *tmpStr in parArray){
    
    }
    BOOL res = NO;
    if ([_db open]) {
        res = [_db executeUpdate:@""];
        [_db close];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
    }
    
    return res;
}

//操作数据库
- (BOOL)createTableWithSQL:(NSString *)sql {
    
    BOOL res = NO;
    if ([_db open]) {
        res = [_db executeUpdate:sql];
        [_db close];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
    }
    
    return res;
}

#pragma mark - INSERT

- (BOOL)insertWithModels:(NSArray *)models Transaction:(BOOL)useTransaction{
    BOOL res = NO;
    __block NSInteger modelsCount = 0;
    dispatch_async(_db_sync_queue, ^(){
        if(useTransaction){
            [_queue inTransaction:^(FMDatabase *db, BOOL *rollback) {
                for(NSObject *tmpObj in models){
                    modelsCount++;
                    BOOL res = [db executeUpdate:[self produceSQLWithModel:tmpObj operate:@"INSERT"]];
                    
                    if (!res) {
                        NSLog(@"error when insert db table");
                    } else {
                        NSLog(@"flog:%ld rollback:%d  success to insert db table",modelsCount,*rollback);
                    }
                    //操作出错，进行会滚
                    if(*rollback){
                        res = !rollback;
                        [db rollback];
                        
                    }
                }
            }];
        }else {
            //两种方式 实现
            
//            if ([_db open]) {
//                BOOL res = [_db executeUpdate:[self produceSQLWithModel:models operate:@"INSERT"]];
//                
//                if (!res) {
//                    [_db close];
//                    NSLog(@"error when insert db table");
//                } else {
//                    NSLog(@"success to insert db table");
//                }
//            }
//            [_db close];
            [_queue inDatabase:^(FMDatabase *db) {
                for(NSObject *tmpObj in models){
                    BOOL res = [db executeUpdate:[self produceSQLWithModel:tmpObj operate:@"INSERT"]];
                    
                    if (!res) {
                        NSLog(@"error when insert db table");
                    } else {
                        NSLog(@" success to insert db table");
                    }
                }
            }];
        }
    });
    return res;
}

/**
 *
 *
 */
- (NSString *)produceSQLWithModel:(NSObject *)model operate:(NSString *)operate {
    NSArray *parArray = [model allParameters];
    NSMutableString *parStr = [[NSMutableString alloc]initWithCapacity:0];
    NSMutableString *valuesStr = [[NSMutableString alloc]initWithCapacity:0];
    [parStr appendFormat:@"INSERT INTO '%@' (",NSStringFromClass([model class])];
    [valuesStr appendString:@" VALUES ("];
    NSInteger flog = parArray.count;
    for(NSString *tmpStr in parArray){
        [parStr appendFormat:@"'%@'",tmpStr];
        [valuesStr appendFormat:@"'%@'",[model valueForKey:tmpStr]];
        if(flog != 1){
            [parStr appendString:@", "];
            [valuesStr appendString:@", "];
        }
        flog--;
    }
    [parStr appendString:@")"];
    [valuesStr appendString:@")"];
    [parStr appendString:valuesStr];
    return parStr;
}

#pragma mark - UPDATE

- (void)selectWithSQL:(NSString *)sql {
    dispatch_async(_db_sync_queue, ^(){
        if ([_db open]) {
            NSLog(@"begin");
            FMResultSet * rs = [_db executeQuery:sql];
            while ([rs next]) {
        //            int Id = [rs intForColumn:ID];
        //            NSString * name = [rs stringForColumn:NAME];
        //            NSString * age = [rs stringForColumn:AGE];
                NSString * tel = [rs stringForColumn:@"tel"];
                NSLog(@"tel:%@",tel);
        //            NSLog(@"id = %d, name = %@, age = %@  address = %@", Id, name, age, address);
            }
            NSLog(@"end");
            [_db close];
        }
    });
}
#pragma mark - ADD
#pragma mark - DELETE
//- (BOOL)insertWithModel:(NSObject *)model {
//
////    NSString *insertSql1= [NSString stringWithFormat:
////                           @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
////                           TABLENAME, NAME, AGE, ADDRESS, @"张三", @"13", @"济南"];
//      BOOL res = NO;
//    
//    NSArray *parArray = [model allParameters];
//    NSMutableString *parStr = [[NSMutableString alloc]initWithCapacity:0];
//    NSMutableString *valuesStr = [[NSMutableString alloc]initWithCapacity:0];
//    [parStr appendFormat:@"INSERT INTO '%@' (",NSStringFromClass([model class])];
//    [valuesStr appendString:@" VALUES ("];
//    NSInteger flog = parArray.count;
//    for(NSString *tmpStr in parArray){
//        [parStr appendFormat:@"'%@'",tmpStr];
//        [valuesStr appendFormat:@"'%@'",[model valueForKey:tmpStr]];
//        if(flog != 1){
//            [parStr appendString:@", "];
//            [valuesStr appendString:@", "];
//        }
//        flog--;
//    }
//    [parStr appendString:@")"];
//    [valuesStr appendString:@")"];
//    [parStr appendString:valuesStr];
//    //NSLog(@"isnert:%@",parStr);
//    
//    //FMDatabase *tmpDB = db;
//    if ([db open]) {
//        
//        BOOL res = [db executeUpdate:parStr];
//        
//        if (!res) {
//            NSLog(@"error when insert db table");
//            return res;
//        } else {
//            NSLog(@"success to insert db table");
//        }
//        [db close];
//    }
//    return res;
//}
//- (BOOL)insertWithSQL:(NSString *)sql {
//    BOOL res = NO;
//    if ([db open]) {
//    
//        BOOL res = [db executeUpdate:sql];
//        
//        if (!res) {
//            NSLog(@"error when insert db table");
//        } else {
//            NSLog(@"success to insert db table");
//        }
//        [db close];
//    }
//
//    return res;
//}
//
//- (BOOL)updateWithSQL:(NSString *)sql {
//    BOOL res = NO;
//    
//    if ([db open]) {
//        BOOL res = [db executeUpdate:sql];
//        if (!res) {
//            NSLog(@"error when update db table");
//        } else {
//            NSLog(@"success to update db table");
//        }
//        [db close];
//        
//    }
//    
//    return res;
//}
//
//- (BOOL)deleteWithSQL:(NSString *)sql {
//    BOOL res = NO;
//    
//    if ([db open]) {
//    
//        BOOL res = [db executeUpdate:sql];
//        if (!res) {
//            NSLog(@"error when delete db table");
//        } else {
//            NSLog(@"success to delete db table");
//        }
//        [db close];
//        
//    }
//    return res;
//}

- (void)inDatabase:(void (^)(DatabaseManager *))block {
    [_queue inDatabase:^(FMDatabase *db) {
    
    }];
}

- (NSString *)documentPathWithName:(NSString *)fileName {
    //@"user.sqlite"
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [docsdir stringByAppendingPathComponent:fileName];
}
@end
