//
//  ZZBaseAPIManager.m
//  Friends PH
//
//  Created by xian on 16/1/5.
//  Copyright © 2016年 xian. All rights reserved.
//

#import "ZZBaseAPIManager.h"

@interface ZZBaseAPIManager()
@property(nonatomic,weak) id<ZZBaseAPIManagerDelegate> child;

@end
@implementation ZZBaseAPIManager

- (instancetype)init
{
    self = [super init];
    if ([self conformsToProtocol:@protocol(ZZBaseAPIManagerDelegate)]) {
        self.child = (id<ZZBaseAPIManagerDelegate>)self;
    }else {
        NSAssert(NO, @"子类必须要实现 ZZBaseAPIManagerDelegate 这个protocol。");
    }
    return self;
}
@end
