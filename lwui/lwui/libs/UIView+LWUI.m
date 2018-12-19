//
//  UIView+LW.m
//  LWUI
//
//  Created by 程恒盛 on 16/11/15.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "UIView+LWUI.h"
#import "UIImage+LWUI.h"

@implementation UIView (LWUI)
- (CGSize)sizeThatFitsToMaxSize:(CGSize)size{
    return [self sizeThatFits:size];
}
- (UIImage *)screenshotsImageWithScale:(CGFloat)scale{
    CGRect bounds = self.bounds;
    UIGraphicsBeginImageContextWithOptions(bounds.size, NO, scale);
    //	UIGraphicsBeginImageContext(bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
- (UIImage *)screenshotsImage{
    UIImage *image = [self screenshotsImageWithScale:0.0];
    return image;
}
+ (CGAffineTransform)transformWithDeviceOrientation:(UIDeviceOrientation)orientation{
    CGAffineTransform m = CGAffineTransformIdentity;
    switch (orientation) {
        case UIDeviceOrientationLandscapeLeft:
            m = CGAffineTransformMakeRotation(M_PI_2);
            break;
        case UIDeviceOrientationLandscapeRight:
            m = CGAffineTransformMakeRotation(-M_PI_2);
            break;
        case UIDeviceOrientationPortrait:
            break;
        case UIDeviceOrientationPortraitUpsideDown:
            m = CGAffineTransformMakeRotation(M_PI);
            break;
        default:
            break;
    }
    return m;
}
-(NSArray <UIView *>*)traversalAllForClass:(Class) class{
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (UIView *v in self.subviews) {
        if ([v isKindOfClass:class]) {
            [views addObject:v];
        }
        [views addObjectsFromArray:[v traversalAllForClass:class]];
    }
    return views.count>0?views:nil;
}
- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
@end

@implementation UIView (LWProgressHUD)
- (UIView *)showView{//因控制器UITableViewController 系统原因，显示在vc.view 的试图是tableview。hud显示时，拖拽会导致tablView滚动。因此修改为显示试图为window 上面
//    UIView *view = [UIApplication sharedApplication].delegate.window;
//    if (!view) {
//        view = self;
//    }
    return self;
}
-(LWProgressHUD *)progressHUD{
    LWProgressHUD *hud = [LWProgressHUD HUDForView:self.showView];
    return hud;
}
- (LWProgressHUD *)showTipWithTitle:(NSString *)title detail:(NSString *)detail animated:(BOOL)animated afterDelay:(NSTimeInterval)delay model:(LWProgressHUDMode) mode{
    [self.showView hideProgressInfoView:YES];
    
    LWProgressHUD *hud = [LWProgressHUD showHUDAddedTo:self.showView animated:YES];
    hud.label.text = title;
    hud.detailsLabel.text = detail;
    hud.label.numberOfLines = 0;
    hud.margin = 20.f;
    hud.contentColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    hud.bezelView.style = LWProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.mode = mode;
    if (delay == 0) {
        return hud;
    }
    [self hideProgressInfoView:animated afterDelay:delay];
    return hud;
}
- (void)hideProgressInfoView:(BOOL)animated{
    [self hideProgressInfoView:animated afterDelay:0];
}
- (void)hideProgressInfoView:(BOOL)animated afterDelay:(NSTimeInterval)delay{
    LWProgressHUD *hud = [LWProgressHUD HUDForView:self.showView];
    if (hud) {
        [hud hideAnimated:animated afterDelay:delay];
    }
}
- (void)autoHideProgressInfoView:(BOOL)animated{
    [self hideProgressInfoView:animated afterDelay:2];
}
- (void)showTipWithTitle:(NSString *)title detail:(NSString *)detail animated:(BOOL)animated{
    [self showTipWithTitle:title detail:detail animated:animated afterDelay:0];
}
- (void)showTipWithTitle:(NSString *)title detail:(NSString *)detail animated:(BOOL)animated afterDelay:(NSTimeInterval)delay{
    [self showTipWithTitle:title detail:detail animated:animated afterDelay:delay model:LWProgressHUDModeText];
}
#pragma mark - 自定义显示试图
- (void)showWithTitle:(NSString *)title detail:(NSString *)detail icon:(UIImage *)icon{
    LWProgressHUD *hud = [self showTipWithTitle:title detail:detail animated:YES afterDelay:0 model:LWProgressHUDModeCustomView];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:icon];
    hud.customView = imageView;
}
#pragma mark - 加载
- (void)showLodingWithTitle:(NSString *)title animated:(BOOL)animated{
    [self showTipWithTitle:title detail:nil animated:animated afterDelay:0 model:LWProgressHUDModeIndeterminate];
}
#pragma mark - 进度条
- (void)showProgressWithTitle:(NSString *)title animated:(BOOL)animated{
    [self showTipWithTitle:title detail:nil animated:animated afterDelay:0 model:LWProgressHUDModeAnnularDeterminate];
}
#pragma mark - 成功 || 失败
- (void)showSuccessWithTitle:(NSString *)title detail:(NSString *)detail{
    UIImage *icon = [UIImage imageNamed_lwui:@"lwui_icon_hud_success.png"];
    [self showWithTitle:title detail:detail icon:icon];
    [self autoHideProgressInfoView:YES];
}
- (void)showFailWithTitle:(NSString *)title detail:(NSString *)detail{
    UIImage *icon = [UIImage imageNamed_lwui:@"lwui_icon_hud_fail.png"];
    [self showWithTitle:title detail:detail icon:icon];
    [self autoHideProgressInfoView:YES];
}
@end



