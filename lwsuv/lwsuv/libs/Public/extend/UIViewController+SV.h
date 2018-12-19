//
//  UIViewController+SV.h
//  CHHomeDec
//
//  Created by 程恒盛 on 2018/8/24.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (SV)
@property (strong, nonatomic) UIImage *backImage;//back 图片

/**
 * 添加back按钮
 */
- (void)setupNavBackItem;

/**
 * back点击事件
 */
- (void)backItemClick;

#pragma mark - 提示
/**
 * 显示loading
 */
- (void)showLoading;

/**
 * 隐藏loading
 */
- (void)hideLoading;
/**
 * 显示错误弹框
 */
- (void)showError:(NSString *)error;

/**
 * 显示成功弹框
 */
- (void)showSuccessWithMsg:(NSString *)msg;
@end
