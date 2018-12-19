//
//  UIViewController+LWUI.h
//  lwui
//
//  Created by Herson on 2018/1/5.
//  Copyright © 2018年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LWUI)

/**
 获取ios 11以下的安全距离
 */
@property (nonatomic,readonly) UIEdgeInsets ios11belowSafeAreaInsets API_DEPRECATED("获取ios 11以下的安全距离", ios(7.0,11.0)); //

@end

@interface UIViewController (LWProgressHUD)

/**
 显示提示
 @param title 标题
 @param detail 内容
 @param animated 是否动画
 */
- (void)showTipWithTitle:(NSString *)title detail:(NSString *)detail animated:(BOOL)animated;
- (void)showTipWithTitle:(NSString *)title detail:(NSString *)detail animated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

/**
 *  隐藏进度显示信息
 *
 *  @param animated 是否动画
 */
- (void)hideProgressInfoView:(BOOL)animated;
- (void)hideProgressInfoView:(BOOL)animated afterDelay:(NSTimeInterval)delay;//延时隐藏
- (void)autoHideProgressInfoView:(BOOL)animated;//定时2秒自动隐藏
@end
