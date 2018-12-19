//
//  UIViewController+LWUI.m
//  lwui
//
//  Created by Herson on 2018/1/5.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "UIViewController+LWUI.h"
#import "UIView+LWUI.h"

@implementation UIViewController (LWUI)
- (UIEdgeInsets)ios11belowSafeAreaInsets{
    UIEdgeInsets insets = UIEdgeInsetsZero;
    //获取导航栏的rect + 状态栏高度
    CGRect navRect = CGRectZero;
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    navRect = navigationBar.frame;
    CGFloat navMaxY = CGRectGetMaxY(navRect);
    CGFloat statusMaxY = 0.f;
    if (navMaxY <= 0) {
        //获取状态栏高度
        CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
        statusMaxY = CGRectGetMaxY(statusRect);
    }
    //获取底部导航栏rect
    CGRect tabBarRect = self.tabBarController.tabBar.frame;
    CGFloat tabBarMaxY = CGRectGetMaxY(tabBarRect);
    insets.top = statusMaxY + navMaxY;
    insets.bottom = tabBarMaxY;
    return insets;
}
@end

@implementation UIViewController (LWProgressHUD)
- (void)showTipWithTitle:(NSString *)title detail:(NSString *)detail animated:(BOOL)animated{
    [self showTipWithTitle:title detail:detail animated:animated afterDelay:0];
}
- (void)showTipWithTitle:(NSString *)title detail:(NSString *)detail animated:(BOOL)animated afterDelay:(NSTimeInterval)delay{
    [self.view showTipWithTitle:title detail:detail animated:animated afterDelay:delay];
}
- (void)hideProgressInfoView:(BOOL)animated{
    [self hideProgressInfoView:animated afterDelay:0];
}
- (void)hideProgressInfoView:(BOOL)animated afterDelay:(NSTimeInterval)delay{
    [self.view hideProgressInfoView:animated afterDelay:delay];
}
- (void)autoHideProgressInfoView:(BOOL)animated{
    [self hideProgressInfoView:animated afterDelay:2];
}
@end
