//
//  SVNavigationController.m
//  LYGoddess
//
//  Created by 程恒盛 on 2018/8/3.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "SVNavigationController.h"

@interface SVNavigationController ()

@end

@implementation SVNavigationController
+ (void)load{
    //两句话需要配合使用才有效
    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = SVColor_CA0C00;
    self.navigationBar.tintColor = SVColor_FFFFFF;
//    self.view.backgroundColor = SVColor_F0F0F0;
    //设置导航栏背景图片为一个空的image，这样就透明了
//    [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
//    [self.navigationBar setShadowImage:[UIImage imageNamed_sv:@""]];
    //设置导航栏透明度
    self.navigationBar.translucent = NO;
}
@end
