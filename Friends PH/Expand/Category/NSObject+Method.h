//
//  NSObject+Method.h
//  Friends PH
//
//  Created by xian on 15/12/11.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Method)

- (NSArray *)arrayTransferWithData:(id)data model:(NSObject *)model;

- (id)modelTransferWithData:(id)data;//data 为 json或者 dict
@end
