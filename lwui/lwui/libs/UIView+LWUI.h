//
//  UIView+LW.h
//  LWUI
//
//  Created by 程恒盛 on 16/11/15.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LWProgressHUD.h"

@interface UIView (LWUI)

#pragma mark - layout

/**
 返回“最佳”尺寸以适合给定尺寸，切并不会超过给定size尺寸。实际上没有调整视图的大小。x/y 为0时，尺寸不受约束

 @param size 尺寸
 @return 最佳尺寸
 */
-(CGSize)sizeThatFitsToMaxSize:(CGSize)size;

#pragma mark -
/**
 获取屏幕最前面的viewcontoller

 @return viewcontoller
 */
- (UIViewController *)topViewController;
/**
 找出当前视图下class（UIView）类
 
 @param class 寻找的UIView
 @return 返回结果集合
 */
-(NSArray <UIView *>*)traversalAllForClass:(Class) class;

/**
 *  返回视图的截屏图片
 *
 *  @return 图片
 */
- (UIImage *)screenshotsImage;

/**
 *  返回视图的截屏图片
 *
 *  @param scale 图片的 scale 值,0代表屏幕 scale
 *
 *  @return 图片
 */
- (UIImage *)screenshotsImageWithScale:(CGFloat)scale;

/**
 *  计算适应设备朝向的仿射变换矩阵
 *
 *  @param orientation 设备朝向,取值如:[UIDevice currentDevice].orientation
 *
 *  @return 自动旋转后的正常显示,所需要的变换矩阵
 */
+ (CGAffineTransform)transformWithDeviceOrientation:(UIDeviceOrientation)orientation;
@end

@interface UIView (LWProgressHUD)

/**
 获取当前试图提示框
 */
@property(readonly, nonatomic) LWProgressHUD *progressHUD;

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

#pragma mark - 自定义显示试图

/**
 加载自定义显示试图

 @param title 标题
 @param detail 描述
 @param icon icon
 */
- (void)showWithTitle:(NSString *)title detail:(NSString *)detail icon:(UIImage *)icon;

#pragma mark - 加载

/**
 加载

 @param title 家在标题
 @param animated 是否显示动画
 */
- (void)showLodingWithTitle:(NSString *)title animated:(BOOL)animated;

#pragma mark - 进度条

/**
 显示进度

 @param title 标题
 @param animated 是否显示动画
 */
- (void)showProgressWithTitle:(NSString *)title animated:(BOOL)animated;

#pragma mark - 成功 || 失败
/**
 显示成功标记（2s后自动消失）

 @param title 标题
 @param detail 内容
 */
- (void)showSuccessWithTitle:(NSString *)title detail:(NSString *)detail;
/**
 显示失败标记（2s后自动消失）
 
 @param title 标题
 @param detail 内容
 */
- (void)showFailWithTitle:(NSString *)title detail:(NSString *)detail;
@end
