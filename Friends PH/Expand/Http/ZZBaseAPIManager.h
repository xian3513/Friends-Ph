//
//  ZZBaseAPIManager.h
//  Friends PH
//
//  Created by xian on 16/1/5.
//  Copyright © 2016年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol  ZZBaseAPIManagerDelegate<NSObject>
@required

- (NSString *)apiMethodName;

@end

@interface ZZBaseAPIManager : NSObject

@end
