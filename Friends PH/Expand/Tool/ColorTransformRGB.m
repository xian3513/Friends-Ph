//
//  ColorTransformRGB.m
//  Friends PH
//
//  Created by xian on 15/12/15.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "ColorTransformRGB.h"

@interface ColorTransformRGB()
@property (nonatomic,strong) NSArray *RGBArray;

@end
@implementation ColorTransformRGB

- (ColorTransformRGB *(^)(UIColor *))color {

    return ^(UIColor * cor){
         [self colorTransformRGB:cor];
        return self;
    };
}

- (void)colorTransformRGB:(UIColor *)color {
    
      //获取颜色的3个数值，分别是数组CS【0】对应红,1对应蓝，2对应绿....
    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    
    //NSLog(@"%f",cs);
    //此方法 在实际使用时 发现  [UIColor blackColor] 返回的是 0100 (暂定为系统bug)
    if(cs[0]==0.000000 && cs[1]==1.000000 && cs[2]==0.000000 && cs[3]==0.000000) {
        self.R = 0;
        self.G = 0;
        self.B = 0;
        self.A = 1;
    }else {
        self.R = cs[0];
        self.G = cs[1];
        self.B = cs[2];
        self.A = cs[3];
    }
    NSLog(@"RGB:%f %f %f %f",cs[0],cs[1],cs[2],cs[3]);
   // NSLog(@"%f,%f,%f,%f",cs[0],cs[1],cs[2],cs[3]);
    

    //返回保存RGB值的数组
   // return RGBStrValueArr;
}
@end
