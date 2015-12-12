//
//  FonExchangeModel.h
//  Friends PH
//
//  Created by xian on 15/12/12.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FonExchangeModel : NSObject

@property(nonatomic,copy) NSString *fromCurrency;
@property(nonatomic,copy) NSString *toCurrency;
@property(nonatomic,copy) NSString *date;
@property(nonatomic,copy) NSString *time;
@property(nonatomic,copy) NSString *currency;
@property(nonatomic,copy) NSString *amount;
@property(nonatomic,copy) NSString *convertedamount;

@end
