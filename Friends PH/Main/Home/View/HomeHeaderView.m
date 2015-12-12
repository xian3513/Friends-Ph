//
//  HomeHeaderView.m
//  Friends PH
//
//  Created by xian on 15/12/10.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "HomeHeaderView.h"
#import "Masonry.h"
@implementation HomeHeaderView {

    UIView *_currentMainView;
    UIView *_hourlyView;
    UIView *_daysView;
    
    UILabel *_updateTimeLab;
    UILabel *_condLab;
    UILabel *_temLab;
}

#pragma mark - set/get method
- (void)setUpdateTime:(NSString *)updateTime {
    _updateTimeLab.text = updateTime;
}

- (void)setCond:(NSString *)cond {
    _condLab.text = cond;
}

- (void)setTemperature:(NSString *)temperature {
    _temLab.text = temperature;
}

#pragma mark - lift cycle method
- (instancetype)init {
    if(self = [super init]) {
        self.frame = CGRectMake(0, 0, 320, 650);
        self.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.2];
        
        [self viewLayout];
    }
    return self;
}

- (void)viewLayout{
    
    //init
    _currentMainView = [UIView new];
    _hourlyView      = [UIView new];
    _daysView        = [UIView new];
    _updateTimeLab   = [UILabel new];
    _condLab         = [UILabel new];
    _temLab          = [UILabel new];
    
    _condLab.backgroundColor = [UIColor blackColor];
    _temLab.backgroundColor = [UIColor blueColor];
    _updateTimeLab.backgroundColor      = [UIColor yellowColor];
    _hourlyView.backgroundColor         = [UIColor purpleColor];
    _currentMainView.backgroundColor    = [UIColor redColor];
    
    [self addSubview:_daysView];
    [self addSubview:_hourlyView];
    [self addSubview:_currentMainView];
   
    [_currentMainView addSubview:_temLab];
    [_currentMainView addSubview:_condLab];
    [_currentMainView addSubview:_updateTimeLab];
    
    //layout view
    [_currentMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.leading.and.trailing.equalTo(self);
        make.height.equalTo(_hourlyView).multipliedBy(1);
    }];
    [_hourlyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_currentMainView.mas_bottom).offset(10);
        make.bottom.equalTo(self.mas_bottom);
        make.leading.trailing.equalTo(self);
    }];
    
    //layout currentview  lab
    [_updateTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_updateTimeLab.superview);
        make.trailing.equalTo(_updateTimeLab.superview).offset(-5);
        make.width.mas_equalTo(120);
    }];
    [_condLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_condLab.superview);
        make.width.mas_equalTo(60);
        make.bottom.equalTo(_temLab.mas_top);
    }];
    [_temLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_temLab.superview);
        make.bottom.equalTo(_temLab.superview.mas_bottom);
        make.height.mas_equalTo(60);
    }];
    
    _updateTimeLab.text = @"ddd";
    _condLab.text = @"condlab";
    _temLab.text = @"temLab";
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
