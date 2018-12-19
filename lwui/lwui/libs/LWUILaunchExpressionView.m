//
//  LWUILaunchExpressionView.m
//  lwlab
//
//  Created by Herson on 2018/2/7.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWUILaunchExpressionView.h"
#import "UIView+LWUI.h"

@interface LWUILaunchExpressionView ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LWUILaunchExpressionView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        self.size = CGSizeZero;
        self.imageView = [[UIImageView alloc] initWithFrame:frame];
        [self addSubview:self.imageView];
    }
    return self;
}
-(void)setImage:(UIImage *)image{
    _image = image;
    self.imageView.image = image;
    if (CGSizeEqualToSize(self.size, CGSizeZero)) {
        self.size = image.size;
    }
}
- (void)setSize:(CGSize)size{
    _size = size;
    CGRect bounds =self.bounds;
    bounds.size = size;
    self.bounds = bounds;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    CGRect f1 = bounds;
    self.imageView.frame = f1;
}
- (void)showExpressionInView:(UIView *)view{
    NSTimeInterval totalAnimationDuration = 8;
    CGFloat heartSize = CGRectGetWidth(self.bounds);
    CGFloat heartCenterX = self.sourcePoint.x;
    CGFloat viewHeight = CGRectGetHeight(view.bounds);
    
    /// Pre-Animation setup
    self.transform = CGAffineTransformMakeScale(0, 0);
    self.alpha = 0;
    
    /// Bloom
    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 0.9;
    } completion:NULL];
    
    NSInteger i = arc4random_uniform(2);
    /// -1 OR 1
    NSInteger rotationDirection = 1 - (2 * i);
    NSInteger rotationFraction = arc4random_uniform(10);
    [UIView animateWithDuration:totalAnimationDuration animations:^{
        self.transform = CGAffineTransformMakeRotation(rotationDirection * M_PI / (16 + rotationFraction * 0.2));
    } completion:NULL];
    
    UIBezierPath *heartTravelPath = [UIBezierPath bezierPath];
    [heartTravelPath moveToPoint:self.sourcePoint];
    
    /// random end point
    CGPoint endPoint = CGPointMake(heartCenterX + (rotationDirection) * arc4random_uniform(2 * heartSize), viewHeight/6.0 + arc4random_uniform(viewHeight / 4.0));
    
    // random Control Points
    NSInteger j = arc4random_uniform(2);
    NSInteger travelDirection = 1 - (2 * j);
    
    /// randomize x and y for control points
    CGFloat xDelta = (heartSize / 2.0 + arc4random_uniform(2 * heartSize)) * travelDirection;
    CGFloat yDelta = MAX(endPoint.y ,MAX(arc4random_uniform(8 * heartSize), heartSize));
    CGPoint controlPoint1 = CGPointMake(heartCenterX + xDelta, viewHeight - yDelta);
    CGPoint controlPoint2 = CGPointMake(heartCenterX - 2 * xDelta, yDelta);
    
    [heartTravelPath addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    keyFrameAnimation.path = heartTravelPath.CGPath;
    keyFrameAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    keyFrameAnimation.duration = totalAnimationDuration + endPoint.y / viewHeight;
    [self.layer addAnimation:keyFrameAnimation forKey:@"positionOnPath"];
    [view addSubview:self];
    
    /// Alpha & remove from superview
    [UIView animateWithDuration:totalAnimationDuration animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
+ (void)showExpressionWithImage:(UIImage *)image sourcePoint:(CGPoint )point{
    LWUILaunchExpressionView *heart = [[LWUILaunchExpressionView alloc] init];
    heart.image = image;
    heart.sourcePoint = point;
    [heart showExpressionInView:heart.topViewController.view];
}
+ (void)showExpressionInView:(UIView *)view Image:(UIImage *)image sourcePoint:(CGPoint )point{
    LWUILaunchExpressionView *heart = [[LWUILaunchExpressionView alloc] init];
    heart.image = image;
    heart.sourcePoint = point;
    [heart showExpressionInView:view];
}
@end
