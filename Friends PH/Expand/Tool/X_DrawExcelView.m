//
//  X_DrawExcelView.m
//  Friends PH
//
//  Created by xian on 15/12/15.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "X_DrawExcelView.h"
#import "CommonMacros.h"

#define defaultLineWidth 1

@implementation X_IndexPath

@end
@implementation X_DrawExcelLayout

- (X_excelTextAlignment)textAlignment {
    if(!_textAlignment) {
        _textAlignment = X_excelTextAlignmentCenter;
    }
    return _textAlignment;
}

-(UIColor *)textColor {
    if(!_textColor){
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}

- (UIFont*)font {
    if(!_font){
        _font = [UIFont systemFontOfSize:13.0f];
    }
    return _font;
}

-(UIColor *)lineColor {
    if(!_lineColor){
        _lineColor = [UIColor blackColor];
    }
    return _lineColor;
}

@end

@interface X_DrawExcelView()

@property(nonatomic,strong) X_DrawExcelLayout *layout;
@property(nonatomic,strong) NSMutableArray *excelContentArray;//里面保存的是 array ,每个array表示一行

@end
@implementation X_DrawExcelView {
    
    CGFloat _cellWidth;
    CGFloat _cellHeight;
}
/**
 *  绘制数据
 */

- (void)drawStringInExcelWithContext:(CGContextRef)context string:(NSString *)string atIndexPath:(X_IndexPath *)indexPath{
   
    CGContextSetLineWidth(context, 1.0);
    CGContextSetRGBFillColor (context, 0.5, 0.5, 0.5, 0.5);
    
    //可以设置 text显示位置
    CGRect rect = CGRectZero;
    rect.origin.x = _cellWidth*indexPath.row;
    rect.origin.y = _cellHeight*indexPath.col;
    rect.size.width = _cellWidth;
    rect.size.height = _cellHeight;
    
    [string drawInRect:rect withAttributes: @{NSFontAttributeName: self.layout.font,NSForegroundColorAttributeName:self.layout.textColor}];
}

/**
 *  绘制矩形边框
 */
- (void)drawRectangleWithContext:(CGContextRef)context {
    
    // 绘制底盘
    UIColor *color = self.layout.backgroundFillColor;
    if(color) {
        //设置矩形边框的填充色
        CGContextSetRGBFillColor(context, T_RGB(color).R, T_RGB(color).G, T_RGB(color).B, T_RGB(color).A);
        CGContextFillRect(context, self.bounds);
        CGContextStrokePath(context);
        
    }
    
    //绘制矩形边框    绘制 row col

    color = self.layout.lineColor;
    CGContextSetRGBStrokeColor(context, T_RGB(color).R, T_RGB(color).G, T_RGB(color).B, T_RGB(color).A);//线条颜色
    CGContextSetLineWidth(context, defaultLineWidth);
    CGContextAddRect(context, self.bounds);
    CGContextStrokePath(context);
    
    
    CGFloat rowWidth = self.bounds.size.width/self.layout.rows;
    CGFloat colHeight = self.bounds.size.height/self.layout.cols;
    _cellWidth = rowWidth;
    _cellHeight = colHeight;
    
    for(int i=0;i<self.layout.rows;i++){
        CGContextSetLineWidth(context, defaultLineWidth);
        CGContextSetRGBStrokeColor(context, T_RGB(color).R, T_RGB(color).G, T_RGB(color).B, T_RGB(color).A);//线条颜色
        CGContextMoveToPoint(context, rowWidth*i, 0);
        CGContextAddLineToPoint(context, rowWidth*i,self.bounds.size.height);
        CGContextStrokePath(context);
    }
    
    for(int i=0;i<self.layout.cols;i++){
        CGContextSetLineWidth(context, defaultLineWidth);
        CGContextSetRGBStrokeColor(context, T_RGB(color).R, T_RGB(color).G, T_RGB(color).B, T_RGB(color).A);//线条颜色
        CGContextMoveToPoint(context, 0, colHeight*i);
        CGContextAddLineToPoint(context, self.bounds.size.width,colHeight*i);
        CGContextStrokePath(context);
    }
}

#pragma mark - lift cycle method

- (instancetype)initWithlayout:(X_DrawExcelLayout *)layout {
    if(self = [super init]) {
        self.layout = layout;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame layout:(X_DrawExcelLayout *)layout {
    if(self = [super initWithFrame:frame]) {
        self.layout = layout;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.excelContentArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画表格
    [self drawRectangleWithContext:context];
    
    //加数据
    for(int i=0;i<self.layout.cols;i++){
        for(int y=0;y<self.layout.rows;y++){
            
            X_IndexPath *indexPath = [[X_IndexPath alloc]init];
            indexPath.col = i;
            indexPath.row = y;
            NSString *str = nil;
            
            if([self.dataSource respondsToSelector:@selector(excelView:CellAtIndex:)]){
              str = [self.dataSource excelView:self CellAtIndex:i*self.layout.rows+y];
            }
            [self drawStringInExcelWithContext:context string:str atIndexPath:indexPath];
        }
    }
    
    
    //    CGContextSetLineWidth(context, 1);
    //    CGContextSetRGBStrokeColor(context, 0.1, 0.1, 0.1, 1);//线条颜色
    //    CGContextMoveToPoint(context, 0, 0);
    //    CGContextAddLineToPoint(context, 0,rect.size.height);
    //    CGContextAddLineToPoint(context, rect.size.width,rect.size.height);
    //    CGContextAddLineToPoint(context, rect.size.width,0);
    //    CGContextAddLineToPoint(context, 0,0);
    //    CGContextStrokePath(context);
    //    //*NO.1画一条线
    //    CGContextSetLineWidth(context, 0.2);
    //    CGContextSetRGBStrokeColor(context, 0.1, 0.1, 0.1, 1);//线条颜色
    //     CGContextMoveToPoint(context, 20, 20);
    //     CGContextAddLineToPoint(context, 200,20);
    //     CGContextStrokePath(context);
    
    //    //*NO.2写文字
    //
    //     CGContextSetLineWidth(context, 1.0);
    //     CGContextSetRGBFillColor (context, 0.5, 0.5, 0.5, 0.5);
    //    [@"公司：北京中软科技股份有限公司\n部门：ERP事业部\n姓名：McLiang" drawInRect:CGRectMake(20, 40, 280, 300) withAttributes: @{NSFontAttributeName: [UIFont systemFontOfSize:13.0f]}];
    
    
    //    //*NO.3画一个正方形图形 没有边框
    //
    //     CGContextSetRGBFillColor(context, 0, 0.25, 0, 0.5);
    //     CGContextFillRect(context, CGRectMake(1, 1, rect.size.width-2, rect.size.height-2));
    //     CGContextStrokePath(context);
    
    
    //*NO.4画正方形边框
    
    //     CGContextSetRGBStrokeColor(context, 0.5, 0.5, 0.5, 1);//线条颜色
    //     CGContextSetLineWidth(context, 2.0);
    //     CGContextAddRect(context, self.bounds);
    //     CGContextStrokePath(context);
    
    
    //    //*绘制虚线
    //     CGContextSetLineWidth(context, 2.0);
    //
    //     CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    //
    //     CGFloat dashArray[] = {2,6,4,2};
    //
    //     CGContextSetLineDash(context, 3, dashArray, 4);//跳过3个再画虚线，所以刚开始有6-（3-2）=5个虚点
    //
    //     CGContextMoveToPoint(context, 10, 200);
    //
    //     CGContextAddQuadCurveToPoint(context, 150, 10, 300, 200);
    //
    //     CGContextStrokePath(context);
    
    /*绘制图片
     NSString* imagePath = [[NSBundle mainBundle] pathForResource:@"dog" ofType:@"png"];
     UIImage* myImageObj = [[UIImage alloc] initWithContentsOfFile:imagePath];
     //[myImageObj drawAtPoint:CGPointMake(0, 0)];
     [myImageObj drawInRect:CGRectMake(0, 0, 320, 480)];
     
     NSString *s = @"我的小狗";
     
     [s drawAtPoint:CGPointMake(100, 0) withFont:[UIFont systemFontOfSize:34.0]];
     */
}
@end
