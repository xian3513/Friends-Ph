//
//  NSArray+Method.h
//  Friends PH
//
//  Created by xian on 15/12/11.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Method)

- (NSArray *)arrayWithData:(id)data;

- (NSDictionary *)dictionaryTransferWithData:(id)data model:(NSObject *)model;
@end
