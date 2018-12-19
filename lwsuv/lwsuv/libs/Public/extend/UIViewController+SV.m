//
//  UIViewController+SV.m
//  CHHomeDec
//
//  Created by 程恒盛 on 2018/8/24.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "UIViewController+SV.h"
#import <objc/runtime.h>


static char *SV_UIViewController_backButton = "SV_UIViewController_backButton";
//static char *SV_UIViewController_rightButton = "SV_UIViewController_rightButton";
static char *SV_UIViewController_backImage = "SV_UIViewController_backImage";

@interface UIViewController ()
@property (strong, nonatomic) SVButton *backButton;

@end

@implementation UIViewController (SV)
//- (void)setupNavRightItem{
//    SVButton *rightNavItem = [[SVButton alloc] init];
//    [rightNavItem setTitle:@"asdfasdf" forState:UIControlStateNormal];
//    rightNavItem.backgroundColor = [UIColor redColor];
//    self.rightNavItem = rightNavItem;
//    rightNavItem.clipsToBounds = YES;
//    [rightNavItem addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
//    [rightNavItem sizeToFit];
//    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightNavItem];
//    self.navigationItem.rightBarButtonItem = rightItem;
//}
- (void)setBackButton:(SVButton *)backButton{
    objc_setAssociatedObject(self, SV_UIViewController_backButton, backButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (SVButton *)backButton{
    return objc_getAssociatedObject(self, SV_UIViewController_backButton);
}
- (void)setBackImage:(UIImage *)backImage{
    objc_setAssociatedObject(self, SV_UIViewController_backImage, backImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (!self.backButton) {
        [self setupNavBackItem];
    }
    [self.backButton setImage:backImage forState:UIControlStateNormal];
}
- (UIImage *)backImage{
    return objc_getAssociatedObject(self, SV_UIViewController_backImage);
}
- (void)setupNavBackItem{
    if (self.navigationController.viewControllers.count <= 1) {
        return;
    }
    UIImage *itemImg = [[UIImage imageNamed_sv:@"chhomedec_basic_back"] imageWithTintColor:SVColor_FFFFFF];
    SVButton *backButton = [[SVButton alloc] init];
    self.backButton = backButton;
    backButton.clipsToBounds = YES;
    [backButton setImage:itemImg forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backItem;
}
- (void)backItemClick{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 提示
/**
 * 显示loading
 */
- (void)showLoading{
    [self.view showLodingWithTitle:nil animated:YES];
//    self.view.progressHUD.bezelView.backgroundColor = [UIColor clearColor];
}
/**
 * 隐藏loading
 */
- (void)hideLoading{
    [self.view hideProgressInfoView:YES];
}
/**
 * 显示错误弹框
 */
- (void)showError:(NSString *)error{
    [self.view showFailWithTitle:error detail:nil];
    [self.view autoHideProgressInfoView:YES];
    [self.view.progressHUD addHideGesture];
}
/**
 * 显示成功弹框
 */
- (void)showSuccessWithMsg:(NSString *)msg{
    [self.view showSuccessWithTitle:msg detail:nil];
    [self.view autoHideProgressInfoView:YES];
    [self.view.progressHUD addHideGesture];
}
@end
