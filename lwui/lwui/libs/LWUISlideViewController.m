//
//  LWUISlideViewController.m
//  LWUI
//
//  Created by 程恒盛 on 16/10/14.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "LWUISlideViewController.h"

CGFloat const LWUISlideViewControllerLeftScaleValue=0.7;
@interface LWUISlideViewController ()
@property(nonatomic, assign) BOOL showPrimary;
@end

@implementation LWUISlideViewController
-(instancetype)init{
    if (self = [super init]) {
        self.leftScaleValue = LWUISlideViewControllerLeftScaleValue;
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
        [self.view addGestureRecognizer:panGesture];
        self.panGesture = panGesture;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark-public
-(void)showPrimary:(BOOL)animation{
    self.showPrimary = YES;
    CGRect bounds = self.view.bounds;
    CGFloat scaleWidth = self.leftScaleValue * bounds.size.width;
    NSArray <UIView *> *allView = [self.view subviews];
    [UIView animateWithDuration:animation?0.3:0.0 animations:^{
        for (UIView *oneOfThem in  allView) {
            oneOfThem.transform = CGAffineTransformMakeTranslation(scaleWidth, 0);
        }
    }];
}
-(void)hiddenPrimary:(BOOL)animation{
    self.showPrimary = NO;
    NSArray <UIView *> *allView = [self.view subviews];
    [UIView animateWithDuration:animation?0.3:0.0 animations:^{
        for (UIView *oneOfThem in  allView) {
            oneOfThem.transform = CGAffineTransformIdentity;
        }
    }];
}
#pragma mark- UIPanGestureRecognizer
-(void)panGesture:(UIPanGestureRecognizer *)pan{
    if (self.detailViewController.childViewControllers.count > 1) {
        return;
    }
    CGPoint p = [pan locationInView:pan.view];
    CGRect bounds = self.view.bounds;
    CGFloat scaleWidth = self.leftScaleValue * bounds.size.width;
    CGPoint translation = [pan translationInView:self.view];
    //禁止超出滚动
    if (self.showPrimary == NO&&translation.x <= 0&&pan.state != UIGestureRecognizerStateEnded) {
        return;
    }else if (self.showPrimary&&translation.x >= 0&&pan.state != UIGestureRecognizerStateEnded) {
        return;
    }
    NSArray <UIView *> *allView = [self.view subviews];
    [UIView animateWithDuration:0.1 animations:^{
        CGPoint pCopy = translation;
        if (self.showPrimary) {
            pCopy.x = scaleWidth + pCopy.x;
        }
        for (UIView *oneOfThem in  allView) {
            if(pan.state == UIGestureRecognizerStateEnded){
                if (pCopy.x<scaleWidth*.5) {
                    pCopy.x = 0;
                    self.showPrimary = NO;
                }else{
                    pCopy.x = scaleWidth;
                    self.showPrimary = YES;
                }
            }else if (p.x>scaleWidth) {
                if (self.showPrimary) {
                    pCopy.x = scaleWidth;
                }
            }
            oneOfThem.transform = CGAffineTransformMakeTranslation(pCopy.x, 0);
        }
    }];
}
#pragma mark- set
-(void)setLeftViewController:(UIViewController *)leftViewController{
    _leftViewController = leftViewController;
    [self addChildViewController:leftViewController];
    [self.view addSubview:leftViewController.view];
    
    CGRect bounds = self.view.bounds;
    CGFloat scaleWidth = self.leftScaleValue * bounds.size.width;
    CGRect f1 = bounds;
    f1.origin.x = -scaleWidth;
    f1.size.width = scaleWidth;
    leftViewController.view.frame = f1;
}
-(void)setDetailViewController:(UIViewController *)detailViewController{
    _detailViewController = detailViewController;
    [self addChildViewController:detailViewController];
    [self.view addSubview:detailViewController.view];
    
    CGRect bounds = self.view.bounds;
    self.detailViewController.view.frame = bounds;
}
@end


