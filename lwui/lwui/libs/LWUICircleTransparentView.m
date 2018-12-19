//
//  LWUICircleTransparentView.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/25.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWUICircleTransparentView.h"

@interface LWUICircleTransparentView ()
@property (strong, nonatomic) UIBezierPath *copyRectBezierPath;

@end

@implementation LWUICircleTransparentView
- (UIBezierPath *)copyRectBezierPath{
    if (!_copyRectBezierPath) {
        CGRect transparentRectRect = self.transparentRect;
        CGFloat radius = transparentRectRect.size.width/2.0f;
        UIBezierPath *rectBezierPath = [UIBezierPath bezierPathWithRoundedRect:transparentRectRect cornerRadius:radius];
        _copyRectBezierPath = rectBezierPath;
    }
    return _copyRectBezierPath;
}
- (UIBezierPath *)rectBezierPath{
    return self.copyRectBezierPath;
}
-(void)setTransparentRect:(CGRect)transparentRect{
    [super setTransparentRect:transparentRect];
    self.copyRectBezierPath = nil;
}
@end
