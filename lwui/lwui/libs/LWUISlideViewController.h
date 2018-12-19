//
//  LWUISlideViewController.h
//  LWUI
//  分屏控制器（实现QQ抽屉效果）
//  Created by 程恒盛 on 16/10/14.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN CGFloat const LWUISlideViewControllerLeftScaleValue;

@interface LWUISlideViewController : UIViewController
@property(nonatomic, strong) UIViewController *leftViewController;//左边VC
@property(nonatomic, strong) UIViewController *detailViewController;//内容
@property(nonatomic, assign) float leftScaleValue;//leftViewController宽度和detailViewController宽度比例 默认为0.7；
@property(nonatomic, readonly) BOOL showPrimary;
-(void)showPrimary:(BOOL)animation;//展示出左边ViewController
-(void)hiddenPrimary:(BOOL)animation;//隐藏左边ViewController

@property (strong, nonatomic) UIPanGestureRecognizer *panGesture;

@end
