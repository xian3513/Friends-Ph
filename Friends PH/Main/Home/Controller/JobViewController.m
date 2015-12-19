//
//  JobViewController.m
//  Friends PH
//
//  Created by xian on 15/12/16.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "JobViewController.h"
#import "BasicNavigationController.h"
@interface JobViewController ()

@end

@implementation JobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 //   self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    self.title = @"职位详情";
    [self.MyNavigationController addNavigationBackItem];

    self.jobNameLab.text = @"PHP开发";
    self.timeLab.text = @"2015.12.12";
    self.treatLab.text = @"20000 ~ 30000";
    self.addressLab.text = @"makati city";
    self.contentLab.text = @"马来西亚上市公司招聘客服人员，要求大专以上学历，男女不限，试用期5000左右 底薪，试用期过后综合收入8000以上，公司给员工交纳各种保险，女生有产假，高大上的工作环境，完善的薪金待遇，让你在异国他乡没有任何后顾之忧，一手资源，诚招各地实力代理 联系QQ 958228784 18701666171";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
