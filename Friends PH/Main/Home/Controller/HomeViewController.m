//
//  HomeViewController.m
//  Friends PH
//
//  Created by xian on 15/12/9.
//  Copyright © 2015年 xian. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeHeaderView.h"
#import "MainTabBarViewController.h"
@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tabView;

@end

@implementation HomeViewController {
    CGFloat lastpace;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabView.tableHeaderView = [[HomeHeaderView alloc]init];

    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg_night_snow.jpg"]];
    self.tabView.backgroundView = imageView;
    // Do any additional setup after loading the view.
//    UIPanGestureRecognizer *panGesture = [[]];
    
    

    
    NSString *str =@"@@Vn@ak°a±@¥@UUI@aUmlwUUxb@¥XU@mmI@a@Kn@@_W@@WI@mUVVXUl@XaV@K@I@aLX@aVI°K@KVLUUwyXkK@kKÆbXnlK@k@aJlU@w@U@»@aXKWn_JXkVKn@°LlKXW@¯U@aUK@kmJUwVIUJkmLK@kka@wUVm@@am@UkUbkK@nmVÒ¯VUWVVmIULk@ma@kkK@nUbUamU`UUVUkKVkkW@@bkmnmUXVKXVL@VbUmbVXJ@nmKÅI@KWKUXVJUL@VUKUX@KUKWL@LUJmaXXm@kVVV@L@VUL@VlK@L@V@LUK@VUb@UUU@°@nVxU`Lkn@`@XVJ@XVmk@UKmV¯LVVn±Wm@Ub@JlLUl@VLk@lmVVn@bnV@V°IVaVJXI°K°V@XXVlVVUnKVlUbWXnV@bV`U@@m@@@nxmn@bXVlL@¤nbUl¦VVUnJVUVl@@bÞL";
    
  //  "encodeOffsets": [[118418, 34392]]
    //decodePolygon(str,118418,34392);
    NSLog(@"decode:%@",decodePolygon(str,118418,34392));
}

NSArray* decodePolygon(NSString *coordinate,int xx,int yy) {
    NSMutableArray *marr = [[NSMutableArray alloc] initWithCapacity:0];
    

    long int prevX = xx;
    long int prevY = yy;
    for (int i = 0; i < coordinate.length; i += 2) {
       
        int x = [coordinate characterAtIndex:i] - 64;
        int y = [coordinate characterAtIndex:i+1] - 64;
       
        x = x>>1^-(x & 1);
        y = y>>1^-(y & 1);
        x += prevX;
        y += prevY;
        prevX = x;
        prevY = y;
      //  NSLog(@"x = %d  y = %d",x,y);
        [marr addObject:@[[NSString stringWithFormat:@"x= %f",x/1024.0],[NSString stringWithFormat:@"y = %f",y/1024.0]]];
        //result.push([x / 1024, y / 1024])
    }
    
    
    return marr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    CGFloat delta = scrollView.contentOffset.y;
    if((lastpace - delta) > 0){
         [self.myTabBarController showAnimation];
      
    } else {
         [self.myTabBarController hideAnimation];
    }
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(decelerate){
        NSLog(@"%@ YES",NSStringFromSelector(_cmd));
    }else {
        NSLog(@"%@ NO",NSStringFromSelector(_cmd));
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
 NSLog(@"%@",NSStringFromSelector(_cmd));
    [self.myTabBarController hideAnimation];
   
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self.myTabBarController showAnimation];
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text= @"aaa";
    return cell;
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
