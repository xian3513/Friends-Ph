//
//  ZZPersistanceRecord.h
//  Friends PH
//
//  Created by xian on 15/12/28.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZZPersistanceRecord : NSObject

- (ZZPersistanceRecord *)mergeRecord:(ZZPersistanceRecord *)record shouldOverride:(BOOL)shouldOverride;
@end
