//
//  Home_Job_TableViewCell.m
//  Friends PH
//
//  Created by xian on 15/12/16.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "Home_Job_TableViewCell.h"

@implementation Home_Job_TableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.nameLab.font = [UIFont boldSystemFontOfSize:14];
    self.addressLab.font = [UIFont systemFontOfSize:13];
    self.treatmentLab.font = [UIFont boldSystemFontOfSize:16];
    self.updateTimeLab.font = [UIFont systemFontOfSize:12];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
