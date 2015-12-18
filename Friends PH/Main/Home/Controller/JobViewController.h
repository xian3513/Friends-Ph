//
//  JobViewController.h
//  Friends PH
//
//  Created by xian on 15/12/16.
//  Copyright © 2015年 xian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobViewController : UIViewController
@property(nonatomic,copy) NSString *jobID;
@property (weak, nonatomic) IBOutlet UILabel *jobNameLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *treatLab;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *contentLab;
@property (weak, nonatomic) IBOutlet UILabel *Publisher;
@property (weak, nonatomic) IBOutlet UIButton *number;
@end
