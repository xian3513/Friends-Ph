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
#import "Masonry.h"
#import "NSString+Method.h"
//@interface ButtonImageView :UIImageView
//@property(nonatomic,assign) BOOL isSelected;
//@property(nonatomic,assign) BOOL haveRedIcon;
//@end
//@interface ButtonImageView ()
//@property(nonatomic,strong) UIImageView *redIcon;
//@end
//@implementation ButtonImageView {
//
//}
//- (void)setHaveRedIcon:(BOOL)haveRedIcon {
//    if(haveRedIcon){
//        [self addSubview:self.redIcon];
//    }else {
//        if(self.redIcon.superview){
//            [self.redIcon removeFromSuperview];
//        }
//    }
//    _haveRedIcon = haveRedIcon;
//}
//-(UIImageView *)redIcon {
//    if(!_redIcon){
//        _redIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cancelSelectButtons"]];
//        _redIcon.frame = CGRectMake(0, 0, 8, 8);
//        _redIcon.center = CGPointMake(self.width/4*3-5, self.height/4+3);
//    }
//    return _redIcon;
//}
//
//@end

@implementation TabbarView {

    NSMutableArray *_itemsArray;
    //NSMutableDictionary *_itemsDictionary;
}

-(instancetype)init {
    if(self = [super init]) {
        
        self.frame = CGRectMake(0, SCREEN_HEIGHT-49, SCREEN_WIDTH, 49);
        _itemsArray = [[NSMutableArray alloc]initWithCapacity:0];
       // _itemsDictionary = [[NSMutableDictionary alloc]initWithCapacity:0];
    }
    return self;
}

- (TabbarViewItem *)dequeueReusableCellWithIdentifier:(NSString *)idfentifier {
//    TabbarViewItem *item = [_itemsDictionary objectForKey:idfentifier];
//    if(!item) {
     return [[TabbarViewItem alloc]init];
//    }
}

//- (void)updateRedIconWithShow:(BOOL)isShow atIndex:(NSInteger)index {
//    if(isShow){
//        ButtonImageView *imageView = [btnImageArray objectAtIndex:index];
//        imageView.haveRedIcon = YES;
//    }else {
//        ButtonImageView *imageView = [btnImageArray objectAtIndex:index];
//        imageView.haveRedIcon = NO;
//    }
//}

- (void)showInView:(UIView *)view {
   
    if([self.delegate respondsToSelector:@selector(tabbar:cellForRowAtIndex:)]){
            
        for(int i=0;i<_itemCount;i++){
            TabbarViewItem *item = [self.delegate tabbar:self cellForRowAtIndex:i];
            CGFloat itemWidth    = (CGFloat)self.width / _itemCount;
            item.frame           = CGRectMake(itemWidth*i, 0, itemWidth, self.height);
            item.tag             = i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(itemPress:)];
            [item addGestureRecognizer:tap];
            [self addSubview:item];
            [_itemsArray addObject:item];
        }
    }
    
    [view addSubview:self];

}

- (void)itemPress:(UITapGestureRecognizer *)tap {
    TabbarViewItem *item = (TabbarViewItem *)tap.view;
    
    if([self.delegate respondsToSelector:@selector(tabbar:didSeletedRowAtIndex:)]){
        [self.delegate tabbar:self didSeletedRowAtIndex:item.tag];
    }
}

//- (void)imageViewPress:(UITapGestureRecognizer *)tap {
//    ButtonImageView *tapView = (ButtonImageView *)tap.view;
//    
//    
//    
//    if(tapView.tag == self.imageArray.count/2){//如果是 点击了中间的按钮
//        if(!addBtnImageView.isSelected){
//            [UIView animateWithDuration:0.3 animations:^(){
//                addBtnImageView.transform = CGAffineTransformMakeRotation(-M_2_PI*3);
//                addBtnImageView.isSelected = YES;
//                currentBtnImv.image = [self.imageArray objectAtIndex:currentBtnImv.tag];
//                //addBtnImageView.image = [UIImage imageNamed:@"closeBtn"];
//            }];
//        }else {
//            [UIView animateWithDuration:0.3 animations:^(){
//                addBtnImageView.transform = CGAffineTransformIdentity;
//                addBtnImageView.isSelected = NO;
//                currentBtnImv.image = [self.selectedImageArray objectAtIndex:currentBtnImv.tag];
//                //addBtnImageView.image = [UIImage imageNamed:@"btnAdd1"];
//            }];
//        }
//       
//    }else {
//        if(currentBtnImv.tag != tapView.tag){//判断两次点击是否为同一个image
//            currentBtnImv.image = [self.imageArray objectAtIndex:currentBtnImv.tag];
//            currentBtnImv = tapView;
//            currentBtnImv.image = [self.selectedImageArray objectAtIndex:tapView.tag];
//        }
//    }
//    
//    if([self.delegate respondsToSelector:@selector(tabbar:didSeletedRowAtIndex:)]){
//        [self.delegate tabbar:self didSeletedRowAtIndex:tapView.tag];
//    }
//}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end

@implementation TabbarViewItem {
    UILabel *_titleLab;
}

- (instancetype)init {
    if(self = [super init]) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.numberOfLines = 2;
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
        
        UIEdgeInsets edge = UIEdgeInsetsMake(0, 0, 0, 0);
        [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_titleLab.superview).insets(edge);
        }];
    }
    return self;
}

- (void)setItemTitle:(NSString *)itemTitle {
    
    _titleLab.font = [UIFont systemFontOfSize:13];
    _titleLab.attributedText = [itemTitle getAttributedStringWithSubString:@"cos" range:NSMakeRange(0, itemTitle.length) fontSize:17];
}

@end
