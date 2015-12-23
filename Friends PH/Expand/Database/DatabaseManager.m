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
    FMDatabase *db;
//    FMDatabaseQueue * _queue;
    dispatch_queue_t _db_sync_queue;
}



@property (nonatomic,strong)FMDatabaseQueue * queue;
@end

@implementation DatabaseManager

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

- (void)openDatabaseWithName:(NSString *)name {
    //1.建立数据库只需要如下一行即可 , 当该文件不存在时，fmdb 会自己创建一个。
    //如果你传入的参数是空串：@“” ，则 fmdb 会在临时文件目录下创建这个数据库，
    //如果你传入的参数是 NULL，则它会建立一个在内存中的数据库
    db = [FMDatabase databaseWithPath:[self documentPathWithName:name]];
    //_queue = [FMDatabaseQueue databaseQueueWithPath:path];
}

- (BOOL)createTableWithModel:(NSObject *)model {
//     NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,ID,NAME,AGE,ADDRESS];
    
    NSArray *parArray = [model allParameters];
    NSMutableString *mstr = [[NSMutableString alloc]initWithCapacity:0];
    [mstr appendFormat:@"CREATE TABLE IF NOT EXISTS '%@' ",NSStringFromClass([model class])];
    for(NSString *tmpStr in parArray){
    
    }
    BOOL res = NO;
    if ([db open]) {
        res = [db executeUpdate:@""];
        [db close];
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
    if ([db open]) {
        res = [db executeUpdate:sql];
        [db close];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"success to creating db table");
        }
    }
    
    return res;
}

- (BOOL)insertWithModel:(NSObject *)model {
    
//    NSString *insertSql1= [NSString stringWithFormat:
//                           @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
//                           TABLENAME, NAME, AGE, ADDRESS, @"张三", @"13", @"济南"];
    
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
    NSLog(@"isnert:%@",parStr);
    
    BOOL res = NO;
    if ([db open]) {
        
        BOOL res = [db executeUpdate:parStr];
        
        if (!res) {
            NSLog(@"error when insert db table");
        } else {
            NSLog(@"success to insert db table");
        }
        [db close];
    }
    
    return res;
}
- (BOOL)insertWithSQL:(NSString *)sql {
    BOOL res = NO;
    if ([db open]) {
    
        BOOL res = [db executeUpdate:sql];
        
        if (!res) {
            NSLog(@"error when insert db table");
        } else {
            NSLog(@"success to insert db table");
        }
        [db close];
    }

    return res;
}

- (BOOL)updateWithSQL:(NSString *)sql {
    BOOL res = NO;
    
    if ([db open]) {
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error when update db table");
        } else {
            NSLog(@"success to update db table");
        }
        [db close];
        
    }
    
    return res;
}

- (BOOL)deleteWithSQL:(NSString *)sql {
    BOOL res = NO;
    
    if ([db open]) {
    
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error when delete db table");
        } else {
            NSLog(@"success to delete db table");
        }
        [db close];
        
    }
    return res;
}

- (void)selectWithSQL:(NSString *)sql {

    if ([db open]) {
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            
//            int Id = [rs intForColumn:ID];
//            NSString * name = [rs stringForColumn:NAME];
//            NSString * age = [rs stringForColumn:AGE];
//            NSString * address = [rs stringForColumn:ADDRESS];
//            NSLog(@"id = %d, name = %@, age = %@  address = %@", Id, name, age, address);
        }
        [db close];
    }

}

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
