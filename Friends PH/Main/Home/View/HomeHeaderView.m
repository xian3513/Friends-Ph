//
//  HomeHeaderView.m
//  Friends PH
//
//  Created by xian on 15/12/10.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "HomeHeaderView.h"
#import "Masonry.h"
#import <CoreText/CoreText.h>

#define view_pace 10

@implementation HomeExchangeView


@end


@interface HomeHeaderView()<X_DrawExcelViewDataSource>

@end
@implementation HomeHeaderView {

    UIView *_currentMainView;
    UIView *_hourlyView;
    UIView *_daysView;
    
    UILabel *_updateTimeLab;
    UILabel *_condLab;
    UILabel *_temLab;
    
    UIButton *_showButton;
    HomeExchangeView *_currentMain_ExchangeView;
}

- (NSString *)excelView:(X_DrawExcelView *)excel CellAtIndex:(NSInteger)index {
    return @[@"CNY",@"PHP",@"1",@"7.345",@"USD",@"CNY",@"1",@"6.45"][index];
}

#pragma mark - set/get method
- (void)setUpdateTime:(NSString *)updateTime {
    _updateTimeLab.text = updateTime;
}

- (void)setCond:(NSString *)cond {
    _condLab.text = cond;
}

- (void)setTemperature:(NSString *)temperature {
    long number = 0.5f;
    //        long number = self.characterSpacing;
    //    long number = stringCharacterSpacing;
    NSMutableAttributedString *attribuedString = [[NSMutableAttributedString alloc]initWithString:temperature];
    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);
    [attribuedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[temperature length])];
    CFRelease(num);
    _temLab.attributedText = attribuedString;
}

#pragma mark - lift cycle method
- (instancetype)init {
    if(self = [super init]) {
        self.frame = CGRectMake(0, 0, 320, 650);
        self.backgroundColor = [UIColor clearColor];
        
        [self viewLayout];
    }
    return self;
}

- (void)viewLayout{
    
    //init
    _currentMainView            = [UIView new];
    _hourlyView                 = [UIView new];
    _daysView                   = [UIView new];
    _updateTimeLab              = [UILabel new];
    _condLab                    = [UILabel new];
    _temLab                     = [UILabel new];
    _showButton                 = [UIButton new];
    //_condLab.backgroundColor = [UIColor blackColor];
    //_temLab.backgroundColor = [UIColor blueColor];
   // _updateTimeLab.backgroundColor      = [UIColor yellowColor];
    //_hourlyView.backgroundColor         = [UIColor purpleColor];
    //_currentMainView.backgroundColor    = [UIColor redColor];
    
    X_DrawExcelLayout *layout = [[X_DrawExcelLayout alloc]init];
    layout.cols = 4;
    layout.rows = 2;
    layout.textColor = [UIColor blueColor];
   
    _currentMain_ExchangeView = [[HomeExchangeView alloc]initWithlayout:layout];
    _currentMain_ExchangeView.backgroundColor = [UIColor yellowColor];
    _currentMain_ExchangeView.dataSource = self;
    
    _condLab.textColor          = [UIColor whiteColor];
    _updateTimeLab.textColor    = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    _temLab.textColor           = [UIColor whiteColor];
    
    _temLab.font                    = [UIFont fontWithName:@"Courier" size:90];
    _updateTimeLab.font         = [UIFont systemFontOfSize:13];
    
    [_showButton setImage:[UIImage imageNamed:@"air_status_bg_white"] forState:UIControlStateNormal];
    [self addSubview:_daysView];
    [self addSubview:_hourlyView];
    [self addSubview:_currentMainView];
   
    [_currentMainView addSubview:_temLab];
    [_currentMainView addSubview:_condLab];
      [_currentMainView addSubview:_showButton];
    [_currentMainView addSubview:_updateTimeLab];
    [_currentMainView addSubview:_currentMain_ExchangeView];
  
    //layout view
    [_currentMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.and.trailing.equalTo(self);
        make.height.equalTo(_hourlyView).multipliedBy(1);
    }];
    [_hourlyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_currentMainView.mas_bottom).offset(view_pace);
        make.bottom.equalTo(self.mas_bottom);
        make.leading.trailing.equalTo(self);
    }];
    
    //layout currentview  lab
    [_updateTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_updateTimeLab.superview).offset(view_pace);
        make.leading.equalTo(_updateTimeLab.superview).offset(view_pace);
        //make.width.mas_equalTo(120);
    }];
    [_condLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_condLab.superview).offset(view_pace);
        make.width.mas_equalTo(_temLab.mas_width);
        make.bottom.equalTo(_temLab.mas_top).offset(-view_pace);
    }];
    [_temLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_temLab.superview).offset(view_pace);
        make.bottom.equalTo(_temLab.superview.mas_bottom);
        make.height.mas_equalTo(70);
    }];
   
    [_showButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_updateTimeLab.mas_top);
        make.trailing.equalTo(_showButton.superview).offset(-view_pace);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
    
    [_currentMain_ExchangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_currentMain_ExchangeView.superview);
        make.trailing.equalTo(_currentMain_ExchangeView.superview).offset(-view_pace);
        make.width.mas_equalTo(_currentMain_ExchangeView.superview.mas_width).multipliedBy(0.48);
        make.height.mas_equalTo(160);
    }];
//    _updateTimeLab.text = @"ddd";
//    _condLab.text = @"condlab";
//    _temLab.text = @"temLab";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
