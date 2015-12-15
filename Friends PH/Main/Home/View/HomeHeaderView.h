//
//  HomeHeaderView.h
//  Friends PH
//
//  Created by xian on 15/12/10.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "X_DrawExcelView.h"

@interface HomeExchangeView : X_DrawExcelView

@property(nonatomic,copy) NSString *USDtoCNY;
@property(nonatomic,copy) NSString *CNYtoPHP;
@end

@interface HomeHeaderView : UIView

@property(nonatomic,copy) NSString *updateTime;
@property(nonatomic,copy) NSString *cond;
@property(nonatomic,copy) NSString *temperature;
@end
