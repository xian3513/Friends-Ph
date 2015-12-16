//
//  BasicModel.m
//  Friends PH
//
//  Created by xian on 15/12/11.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "BasicModel.h"
#import "MJExtension.h"
@implementation BasicModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.replaceKey = [NSDictionary new];
        self.objectInArray = [NSDictionary new];
    }
    return self;
}
@end
