//
//  LWUIRectTransparentView.m
//  gwdocktracker
//
//  Created by Herson on 2017/11/10.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import "LWUIRectTransparentView.h"

@interface LWUIRectTransparentView ()
@property(nonatomic, strong) CAShapeLayer *shapeLayer;
@property(nonatomic, strong) UIColor *transparentColor;//默认clearcolor
@property(nonatomic, strong) UIBezierPath *rectBezierPath;//呈现Bezier
@end
@implementation LWUIRectTransparentView{
    UIColor *__backgroundColor;
    CGRect __lastTransparentRect;
    BOOL __isAnimation;
}
- (instancetype)init{
    if (self = [super init]) {
        self.transparentColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        __isAnimation = NO;
        //
        [self.layer addSublayer:self.shapeLayer];
    }
    return self;
}
- (void)setTransparentRect:(CGRect)transparentRect{
    if (!CGRectEqualToRect(_transparentRect, transparentRect)) {
        self.rectBezierPath = nil;
        _transparentRect = transparentRect;
        __isAnimation = NO;
        [self setNeedsDisplay];
    }
}
-(void)transparentRect:(CGRect)rect animated:(BOOL)animated{
    self.transparentRect = rect;
    __isAnimation = animated;
}
- (void)setTransparentColor:(UIColor *)transparentColor{
    _transparentColor = transparentColor;
    [super setBackgroundColor:transparentColor];
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    __backgroundColor = backgroundColor;
    self.shapeLayer.fillColor = backgroundColor.CGColor;
}
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    //中间镂空的矩形框
    if (CGRectIsEmpty(__lastTransparentRect)){
        __lastTransparentRect = self.transparentRect;
    }
    //上一次的Path
    UIBezierPath *lastPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    UIBezierPath *lastCirclePath = [UIBezierPath bezierPathWithRect:__lastTransparentRect];
    [lastPath appendPath:lastCirclePath];
    [lastPath setUsesEvenOddFillRule:YES];
    //
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:0];
    //镂空
    UIBezierPath *circlePath = self.rectBezierPath;
    
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    if (__isAnimation) {
        //过度动画
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
        animation.fromValue = (__bridge id)lastPath.CGPath;
        animation.toValue = (__bridge id) path.CGPath;
        animation.beginTime = 0;
        animation.duration = 0.2f;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [self.shapeLayer addAnimation:animation forKey:nil];
    }else{
        self.shapeLayer.path = path.CGPath;
    }
    __lastTransparentRect = self.transparentRect;
}
- (UIBezierPath *)rectBezierPath{
    if (!_rectBezierPath) {
        CGRect transparentRectRect = self.transparentRect;
        UIBezierPath *rectBezierPath = [UIBezierPath bezierPathWithRoundedRect:transparentRectRect cornerRadius:0];
        _rectBezierPath = rectBezierPath;
    }
    return _rectBezierPath;
}
- (CAShapeLayer *)shapeLayer {
    if (!_shapeLayer) {
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.frame = self.bounds;
        _shapeLayer.fillRule = kCAFillRuleEvenOdd;
    }
    return _shapeLayer;
}
@end

