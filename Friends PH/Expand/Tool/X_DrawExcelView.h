//
//  X_DrawExcelView.h
//  Friends PH
//
//  Created by xian on 15/12/15.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    X_excelTextAlignmentLeft,
    X_excelTextAlignmentCenter,
    X_excelTextAlignmentRight
}X_excelTextAlignment;

@protocol X_DrawExcelViewDataSource;

@interface X_IndexPath : NSObject
@property(nonatomic) NSInteger row;
@property(nonatomic) NSInteger col;
@end

@interface X_DrawExcelLayout : NSObject

@property(nonatomic) NSInteger rows;//列
@property(nonatomic) NSInteger cols;//行
@property(nonatomic,strong) UIFont *font;    // 13
@property(nonatomic,strong) UIColor *textColor; //  black
@property(nonatomic) X_excelTextAlignment textAlignment; // center
@property(nonatomic,strong) UIColor *lineColor;
@property(nonatomic,strong) UIColor *backgroundFillColor;
@end

@interface X_DrawExcelView : UIView



@property(nonatomic,weak) id<X_DrawExcelViewDataSource> dataSource;


- (instancetype)initWithlayout:(X_DrawExcelLayout *)layout;
- (instancetype)initWithFrame:(CGRect)frame layout:(X_DrawExcelLayout *)layout;
@end

@protocol X_DrawExcelViewDataSource <NSObject>

@required

- (NSString *)excelView:(X_DrawExcelView *)excel CellAtIndex:(NSInteger)index;

@end
