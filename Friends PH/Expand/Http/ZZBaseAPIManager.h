//
//  ZZBaseAPIManager.h
//  Friends PH
//
//  Created by xian on 16/1/5.
//  Copyright © 2016年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZZBaseAPIManager;

@protocol  ZZBaseAPIManagerDelegate<NSObject>
@required

/**
 *  get api name
 *
 *  @param no
 *
 *  @return api name
 */
- (NSString *)apiMethodName;

/**
 *  startRequest
 *
 *  @param api params
 *
 *  @return delegate call back
 */
- (void)loadDataWithParams:(NSDictionary *)params;

@end

@protocol APIManagerDelegate <NSObject>

@required
- (void)apiManagerDidSuccess:(ZZBaseAPIManager *)manager;

@end

@interface ZZBaseAPIManager : NSObject

@property(nonatomic,weak,readonly) ZZBaseAPIManager<APIManagerDelegate> *delegate;

- (instancetype)initWithTargat:(id<APIManagerDelegate>)targat;

@end
