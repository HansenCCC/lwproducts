//
//  LWUILaunchExpressionView.h
//  lwlab
//  自定义直播喷射表情动画
//  Created by Herson on 2018/2/7.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWUILaunchExpressionView : UIView
@property (assign, nonatomic) CGPoint sourcePoint;//起始坐标
@property (strong, nonatomic) UIImage *image;//喷射图片
@property (assign, nonatomic) CGSize size;//试图尺寸（默认图片大小）


/**
 发射图片

 @param view 目标试图
 */
- (void)showExpressionInView:(UIView *)view;

/**
 发射图片

 @param view 目标试图
 @param image 发射试图
 @param point 起始坐标
 */
+ (void)showExpressionInView:(UIView *)view Image:(UIImage *)image sourcePoint:(CGPoint )point;
+ (void)showExpressionWithImage:(UIImage *)image sourcePoint:(CGPoint )point;
@end


