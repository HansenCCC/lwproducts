//
//  LWUIRectTransparentView.h
//  gwdocktracker
//  中间透明view(用途：我扫描二维码、用户提示等)
//      默认中间透明形状为矩形，重写rectBezierPath修改形状
//  Created by Herson on 2017/11/10.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWUIRectTransparentView : UIView
@property(nonatomic, readonly) CAShapeLayer *shapeLayer;//layer
@property(nonatomic, readonly) UIBezierPath *rectBezierPath;//呈现Bezier

/**
 设置裁剪的区域
 */
@property(assign, nonatomic) CGRect transparentRect;

/**
 设置裁剪的区域

 @param rect 裁剪区域
 @param animated 是否使用动画
 */
-(void)transparentRect:(CGRect)rect animated:(BOOL)animated;
@end
