//
//  NSString+Method.m
//  ChildFine
//
//  Created by xian on 15/11/6.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "NSString+Method.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Method)

- (NSMutableAttributedString *)getAttributedStringWithSubString:(NSString *)subString range:(NSRange)range fontSize:(CGFloat)size {
    NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",self,subString]];
    
//    //设置行间距
//    NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
//    [paragraphStyle1 setLineSpacing:space];
//    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [string length])];
    
     [attributedString1 addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:size] range:range];
    return attributedString1;
}
//md5 encode
-(NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int)strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02X", digest[i]];
    
    return output;
}

//MD5  32
//+(NSString *) md5String32:(NSString *)str
//{
//    const char *cStr = [str UTF8String];
//    unsigned char digest[CC_MD5_DIGEST_LENGTH];
//    CC_MD5( cStr, strlen(cStr), digest );
//    
//    NSMutableString *output = [[NSMutableString alloc]init];
//    
//    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
//        [output appendFormat:@"%02x", digest[i]];
//    
//    return output;
//}

//sha1 encode
-(NSString*) sha1:(NSString *)str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
