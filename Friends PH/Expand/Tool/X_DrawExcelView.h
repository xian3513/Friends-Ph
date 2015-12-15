//
//  X_DrawExcelView.h
//  Friends PH
//
//  Created by xian on 15/12/15.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol X_DrawExcelViewDataSource;

@interface X_IndexPath : NSObject
@property(nonatomic) NSInteger row;
@property(nonatomic) NSInteger col;
@end

@interface X_DrawExcelLayout : NSObject

@property(nonatomic) NSInteger rows;//列
@property(nonatomic) NSInteger cols;//行
@property(nonatomic,strong) UIFont *textFont;
@property(nonatomic,strong) UIColor *textColor;
@end

@interface X_DrawExcelView : UIView

@property(nonatomic,strong) UIColor *x_edgBackgroundColor;
@property(nonatomic,strong) UIColor *x_edgBackgroundFillColor;

@property(nonatomic,weak) id<X_DrawExcelViewDataSource> dataSource;


- (instancetype)initWithlayout:(X_DrawExcelLayout *)layout;
- (instancetype)initWithFrame:(CGRect)frame layout:(X_DrawExcelLayout *)layout;
@end

@protocol X_DrawExcelViewDataSource <NSObject>

@required

- (NSString *)excelView:(X_DrawExcelView *)excel CellAtIndex:(NSInteger)index;

@end
