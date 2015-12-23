//
//  AddressBookViewController.m
//  Friends PH
//
//  Created by xian on 15/12/23.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "AddressBookViewController.h"
#import <AddressBook/AddressBook.h>

#import "AddressBookModel.h"
#import "UserHandler.h"
#import "AddressBookTable.h"


static  NSString *TABLENAME = @"AddressBookTable";
static  NSString *ID = @"id";
static  NSString *NAME = @"name";
static  NSString *AGE = @"age";
static  NSString *ADDRESS = @"tel";
@interface AddressBookViewController ()

@end

@implementation AddressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"addressBook";
    
    UserHandler *handler = [UserHandler manager];
    [handler.db openDatabaseWithName:@"myAddress.db"];
    
      NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' INTEGER PRIMARY KEY AUTOINCREMENT, '%@' TEXT, '%@' INTEGER, '%@' TEXT)",TABLENAME,ID,NAME,AGE,ADDRESS];
    
    [handler.db createTableWithSQL:sqlCreateTable];
    
    AddressBookTable *model = [[AddressBookTable alloc]init];
    model.tel = @"ss";
    model.name = @"zxx";
    [handler.db insertWithModel:model];
    
    
    
    
    
    
    
    
    //[[DatabaseManager shareDatabaseQueue] openDatabaseWithPath:@"myAddress.db"];
  
//    FMDatabase *db = [FMDatabase databaseWithPath:[self documentPathWithName:@"myAddress.db"]];
//    BOOL res = NO;
//    if ([db open]) {
//        res = [db executeUpdate:sqlCreateTable];
//        [db close];
//        if (!res) {
//            NSLog(@"error when creating db table");
//        } else {
//            NSLog(@"success to creating db table");
//        }
//    }
    NSString *insertSql1= [NSString stringWithFormat:
                          @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
                          TABLENAME, NAME, AGE, ADDRESS, @"张三", @"13", @"济南"];
    
   // [[DatabaseManager shareDatabaseQueue] createTableWithSQL:sqlCreateTable saveFileName:@"myAddress"];
  FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self documentPathWithName:@"myAddress.db"]];
    
    
//    [queue inDatabase:^(FMDatabase *db) {
//    
////        for(int i=0;i<2000;i++){
////            //        AddressBookModel *model = [[AddressBookModel alloc]init];
////            //        model.recordID = i;
////            //        [array addObject:model];
////            //        NSLog(@"ID:%ld",model.recordID);
////            NSLog(@"ID:%d",i);
////            [db executeUpdate:insertSql1];
////        }
//        if ([db open]) {
//            NSString * sql = [NSString stringWithFormat:
//                              @"SELECT * FROM %@",TABLENAME];
//            FMResultSet * rs = [db executeQuery:sql];
//            while ([rs next]) {
//                int Id = [rs intForColumn:ID];
//                NSString * name = [rs stringForColumn:NAME];
//                NSString * age = [rs stringForColumn:AGE];
//                NSString * address = [rs stringForColumn:ADDRESS];
//                NSLog(@"id = %d, name = %@, age = %@  address = %@", Id, name, age, address);
//            }
//            [db close];
//        }
//    }];
    
//    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
//    for(int i=0;i<2000;i++){
////        AddressBookModel *model = [[AddressBookModel alloc]init];
////        model.recordID = i;
////        [array addObject:model];
////        NSLog(@"ID:%ld",model.recordID);
//        NSLog(@"ID:%d",i);
//    [[DatabaseManager shareDatabaseQueue] insertWithSQL:insertSql1];
//    }
    
    
    
    
    
    
//        dispatch_queue_t urls_queue = dispatch_queue_create("blog.devtang.com", NULL);
//    dispatch_async(urls_queue, ^{
//        FMDatabase *db = [FMDatabase databaseWithPath:[self documentPathWithName:@"myAddress.db"]];
//        BOOL res = NO;
//        if ([db open]) {
//            res = [db executeUpdate:sqlCreateTable];
//            [db close];
//            if (!res) {
//                NSLog(@"error when creating db table");
//            } else {
//                NSLog(@"success to creating db table");
//            }
//        }
//        for(int i=0;i<10000;i++){
//            NSLog(@"ID:%d",i);
//            if ([db open]) {
//                NSString *insertSql1= [NSString stringWithFormat:
//                                       @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",
//                                       TABLENAME, NAME, AGE, ADDRESS, @"张三", @"13", @"济南"];
//                BOOL res = [db executeUpdate:insertSql1];
//                
//                if (!res) {
//                    NSLog(@"error when insert db table");
//                } else {
//                    NSLog(@"success to insert db table");
//                }
//                
//                [db close];
//                
//            }
//        }
//
//       // [self select];
//    });
}

- (void)select {
    FMDatabase *db = [FMDatabase databaseWithPath:[self documentPathWithName:@"myAddress.db"]];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@",TABLENAME];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next]) {
            int Id = [rs intForColumn:ID];
            NSString * name = [rs stringForColumn:NAME];
            NSString * age = [rs stringForColumn:AGE];
            NSString * address = [rs stringForColumn:ADDRESS];
            NSLog(@"id = %d, name = %@, age = %@  address = %@", Id, name, age, address);
        }
        [db close];
    }
    
}

- (NSString *)documentPathWithName:(NSString *)fileName {
    //@"user.sqlite"
    NSString* docsdir = [NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [docsdir stringByAppendingPathComponent:fileName];
}

- (void)readAddressBook {
    ABAddressBookRef addressBooks = nil;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 6.0)
        
    {
        addressBooks =  ABAddressBookCreateWithOptions(NULL, NULL);
        
        //获取通讯录权限
        
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(addressBooks, ^(bool granted, CFErrorRef error){dispatch_semaphore_signal(sema);});
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        
        //        dispatch_release(sema);
        
    }
    
    else
        
    {
        addressBooks = ABAddressBookCreate();
        
    }
    //获取通讯录中的所有人
    CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addressBooks);
    //通讯录中人数
    CFIndex nPeople = ABAddressBookGetPersonCount(addressBooks);
    
    //循环，获取每个人的个人信息
    for (NSInteger i = 0; i < nPeople; i++)
    {
        //新建一个addressBook model类
        AddressBookModel *addressBook = [[AddressBookModel alloc] init];
        //获取个人
        ABRecordRef person = CFArrayGetValueAtIndex(allPeople, i);
        //获取个人名字
        CFTypeRef abName = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFTypeRef abLastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        CFStringRef abFullName = ABRecordCopyCompositeName(person);
        NSString *nameString = (__bridge NSString *)abName;
        NSString *lastNameString = (__bridge NSString *)abLastName;
        
        if ((__bridge id)abFullName != nil) {
            nameString = (__bridge NSString *)abFullName;
        } else {
            if ((__bridge id)abLastName != nil)
            {
                nameString = [NSString stringWithFormat:@"%@ %@", nameString, lastNameString];
            }
        }
        addressBook.name = nameString;
        addressBook.recordID = (int)ABRecordGetRecordID(person);;
        
        ABPropertyID multiProperties[] = {
            kABPersonPhoneProperty,
            kABPersonEmailProperty
        };
        NSInteger multiPropertiesTotal = sizeof(multiProperties) / sizeof(ABPropertyID);
        for (NSInteger j = 0; j < multiPropertiesTotal; j++) {
            ABPropertyID property = multiProperties[j];
            ABMultiValueRef valuesRef = ABRecordCopyValue(person, property);
            NSInteger valuesCount = 0;
            if (valuesRef != nil) valuesCount = ABMultiValueGetCount(valuesRef);
            
            if (valuesCount == 0) {
                CFRelease(valuesRef);
                continue;
            }
            //获取电话号码和email
            for (NSInteger k = 0; k < valuesCount; k++) {
                CFTypeRef value = ABMultiValueCopyValueAtIndex(valuesRef, k);
                switch (j) {
                    case 0: {// Phone number
                        addressBook.tel = (__bridge NSString*)value;
                        break;
                    }
                    case 1: {// Email
                        addressBook.email = (__bridge NSString*)value;
                        break;
                    }
                }
                CFRelease(value);
            }
            CFRelease(valuesRef);
        }
        //将个人信息添加到数组中，循环完成后addressBookTemp中包含所有联系人的信息
        NSLog(@"addressBook:%@",addressBook);
        //  [addressBookTemp addObject:addressBook];
        
        if (abName) CFRelease(abName);
        if (abLastName) CFRelease(abLastName);
        if (abFullName) CFRelease(abFullName);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
