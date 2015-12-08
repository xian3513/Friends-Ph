//
//  TabbarView.m
//  KKHDome
//
//  Created by xian on 15/11/30.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "TabbarView.h"
#import "CommonMacros.h"
#import "UIView+Frame.h"

@interface ButtonImageView :UIImageView
@property(nonatomic,assign) BOOL isSelected;
@property(nonatomic,assign) BOOL haveRedIcon;
@end
@interface ButtonImageView ()
@property(nonatomic,strong) UIImageView *redIcon;
@end
@implementation ButtonImageView {

}
- (void)setHaveRedIcon:(BOOL)haveRedIcon {
    if(haveRedIcon){
        [self addSubview:self.redIcon];
    }else {
        if(self.redIcon.superview){
            [self.redIcon removeFromSuperview];
        }
    }
    _haveRedIcon = haveRedIcon;
}
-(UIImageView *)redIcon {
    if(!_redIcon){
        _redIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cancelSelectButtons"]];
        _redIcon.frame = CGRectMake(0, 0, 8, 8);
        _redIcon.center = CGPointMake(self.width/4*3-5, self.height/4+3);
    }
    return _redIcon;
}

@end

@implementation TabbarView {
    ButtonImageView *addBtnImageView;
    ButtonImageView *currentBtnImv;
    
    NSMutableArray *btnImageArray;
}

-(instancetype)init {
    if(self = [super init]) {
        
        
        self.frame = CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
        btnImageArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return self;
}

- (void)updateRedIconWithShow:(BOOL)isShow atIndex:(NSInteger)index {
    if(isShow){
        ButtonImageView *imageView = [btnImageArray objectAtIndex:index];
        imageView.haveRedIcon = YES;
    }else {
        ButtonImageView *imageView = [btnImageArray objectAtIndex:index];
        imageView.haveRedIcon = NO;
    }
}

- (void)showInView:(UIView *)view {
    if(self.imageArray.count == self.selectedImageArray.count){
        
        NSInteger count = self.imageArray.count;
        CGFloat width = SCREEN_WIDTH/count;
        
        for(int i=0;i<count;i++){
            ButtonImageView *imageView = [[ButtonImageView alloc]initWithFrame:CGRectMake(width*i, 0, width, self.height)];
            
            imageView.tag          = i;
            imageView.isSelected = NO;
            imageView.userInteractionEnabled = YES;
            imageView.image        = [self.imageArray objectAtIndex:i];
            [self addSubview:imageView];
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewPress:)];
            [imageView addGestureRecognizer:tap];
            
            if(i == count/2){
                addBtnImageView = [[ButtonImageView alloc]initWithImage:[UIImage imageNamed:@"btnAdd1"]];
                addBtnImageView.frame = CGRectMake(0, 0, imageView.width, imageView.height);
                addBtnImageView.center = CGPointMake(imageView.width/2, imageView.height/2);
                [imageView addSubview:addBtnImageView];
            } else if (i == 0){
                currentBtnImv = imageView;
               
                currentBtnImv.image = [self.selectedImageArray objectAtIndex:i];
            }else if(i == 4){
                imageView.haveRedIcon = YES;
            }
            [btnImageArray addObject:imageView];
        }
    }
    
    [view addSubview:self];

}

- (void)imageViewPress:(UITapGestureRecognizer *)tap {
    ButtonImageView *tapView = (ButtonImageView *)tap.view;
    
    
    
    if(tapView.tag == self.imageArray.count/2){//如果是 点击了中间的按钮
        if(!addBtnImageView.isSelected){
            [UIView animateWithDuration:0.3 animations:^(){
                addBtnImageView.transform = CGAffineTransformMakeRotation(-M_2_PI*3);
                addBtnImageView.isSelected = YES;
                currentBtnImv.image = [self.imageArray objectAtIndex:currentBtnImv.tag];
                //addBtnImageView.image = [UIImage imageNamed:@"closeBtn"];
            }];
        }else {
            [UIView animateWithDuration:0.3 animations:^(){
                addBtnImageView.transform = CGAffineTransformIdentity;
                addBtnImageView.isSelected = NO;
                currentBtnImv.image = [self.selectedImageArray objectAtIndex:currentBtnImv.tag];
                //addBtnImageView.image = [UIImage imageNamed:@"btnAdd1"];
            }];
        }
       
    }else {
        if(currentBtnImv.tag != tapView.tag){//判断两次点击是否为同一个image
            currentBtnImv.image = [self.imageArray objectAtIndex:currentBtnImv.tag];
            currentBtnImv = tapView;
            currentBtnImv.image = [self.selectedImageArray objectAtIndex:tapView.tag];
        }
    }
    
    if([self.delegate respondsToSelector:@selector(tabbar:didSeletedRowAtIndex:)]){
        [self.delegate tabbar:self didSeletedRowAtIndex:tapView.tag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
