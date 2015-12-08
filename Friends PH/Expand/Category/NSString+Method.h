//
//  NSString+Method.h
//  ChildFine
//
//  Created by xian on 15/11/6.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Method)
/*
 加密实现MD5和SHA1
 */
-(NSString *) md5:(NSString *)str;
//+(NSString *) md5String32:(NSString *)str;
-(NSString*) sha1:(NSString *)str;
@end
