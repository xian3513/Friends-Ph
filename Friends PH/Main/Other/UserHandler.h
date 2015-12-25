//
//  UserHandler.h
//  Friends PH
//
//  Created by xian on 15/12/23.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseManager.h"
@interface UserHandler : NSObject

@property(nonatomic,strong)DatabaseManager *db;

+ (UserHandler *)manager;
@end
