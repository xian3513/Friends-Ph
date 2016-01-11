//
//  HomeAPIManager.h
//  Friends PH
//
//  Created by xian on 16/1/6.
//  Copyright © 2016年 xian. All rights reserved.
//

#import "ZZBaseAPIManager.h"

@interface HomeAPIManager : ZZBaseAPIManager<ZZBaseAPIManagerDelegate>

- (void)startWeaterRequest;
@end
