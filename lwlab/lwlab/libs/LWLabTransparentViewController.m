//
//  LWLabTransparentViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/25.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabTransparentViewController.h"

@interface LWLabTransparentViewController ()
@property (strong, nonatomic) LWUIRectTransparentView *transparentView;
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation LWLabTransparentViewController
- (instancetype)init{
    if (self = [super init]) {
        self.type = LWUIRectTransparentViewTypeRectangle;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:@selector(_rightBarButtonItemAction:)];
    [self _loadView];
    
    self.imageView = [[UIImageView alloc] init];
    [self.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.imageView setImage:[UIImage imageNamed_lwlab:@"lwlab_icon.png"]];
    [self.view addSubview:self.imageView];
    //
    [self touchesTransparentViewPoint:self.view.center];
}
-(void)setType:(LWUIRectTransparentViewType)type{
    _type = type;
    //
    [self.transparentView removeFromSuperview];
    self.transparentView = nil;
    if (type == LWUIRectTransparentViewTypeRectangle) {
        self.transparentView = [[LWUIRectTransparentView alloc] init];
    }else if(type == LWUIRectTransparentViewTypeCircular){
        self.transparentView = [[LWUICircleTransparentView alloc] init];
    }
    [self.view addSubview:self.transparentView];
    [self _loadView];
    [self viewDidLayoutSubviews];//layout
}
- (void)_rightBarButtonItemAction:(id)sender{
    self.type = self.type==LWUIRectTransparentViewTypeRectangle?LWUIRectTransparentViewTypeCircular:LWUIRectTransparentViewTypeRectangle;
    [self touchesTransparentViewPoint:self.view.center];
}
- (void)_loadView{
    NSString *title;
    if (self.type == LWUIRectTransparentViewTypeRectangle) {
        title = @"矩形";
    }else if(self.type == LWUIRectTransparentViewTypeCircular){
        title = @"圆形";
    }
    self.title = title;
    self.navigationItem.rightBarButtonItem.title = title;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    self.imageView.frame = f1;
    self.transparentView.frame = f1;
}
#pragma mark - touch
- (void)touchesTransparentViewPoint:(CGPoint )point{
    CGRect bounds = self.view.bounds;
    CGRect f1 = bounds;
    f1.size = CGSizeMake(200.f, 200.f);
    f1.origin.x = point.x - f1.size.width/2;
    f1.origin.y = point.y - f1.size.height/2;
    [self.transparentView transparentRect:f1 animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    UITouch * touch = touches.anyObject;//获取触摸对象
    CGPoint point = [touch locationInView:self.view];
    [self touchesTransparentViewPoint:point];
}
@end
