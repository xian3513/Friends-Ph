//
//  ColorTransformRGB.h
//  Friends PH
//
//  Created by xian on 15/12/15.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorTransformRGB : NSObject

@property(nonatomic, readonly) ColorTransformRGB *(^color)(UIColor * cor);
@property(nonatomic) CGFloat R;
@property(nonatomic) CGFloat G;
@property(nonatomic) CGFloat B;
@property(nonatomic) CGFloat A;

@end
