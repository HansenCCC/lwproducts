//
//  LWLabStudioViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/18.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabStudioViewController.h"
#import "LWLabMessage.h"
#import "LWLabApiMessage.h"

#import "AppDelegate.h"
@interface LWLabStudioViewController ()
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation LWLabStudioViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.backgroundColor = [UIColor redColor];
    self.imageView.image = [UIImage imageNamed_lwlab:@"lwlab_icon.png"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:self.imageView];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    
    NSString *hexString = [UIColor hexStringFromColor:[UIColor lightGrayColor]];
    NSLog(@"%@",hexString);
    
    NSLog(@"%@",self.navigationController.navigationBar);
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        insets = self.view.safeAreaInsets;
    }else{
        insets = self.ios11belowSafeAreaInsets;
    }
    bounds = UIEdgeInsetsInsetRect(bounds,insets);
    CGRect f1 = bounds;
    f1.size = CGSizeMake(100, 100);
    self.imageView.frame = f1;
}
@end
