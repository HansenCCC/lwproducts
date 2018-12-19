//
//  LWLabExpressionViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/27.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabExpressionViewController.h"

@interface LWLabExpressionViewController ()
@property (strong, nonatomic) HVUIFlowLayoutButton *expressionButton;
@property (strong, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL isBegin;
@end

@implementation LWLabExpressionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"发射表情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleDone target:self action:@selector(_rightBarButtonItemAction:)];
    //
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(__showExpressionForTime) userInfo:nil repeats:YES];
    self.isBegin = NO;
    //
    self.expressionButton = [[HVUIFlowLayoutButton alloc] init];
    [self.expressionButton setImage:[UIImage imageNamed_lwlab:@"lwlab_icon.png"] forState:UIControlStateNormal];
    self.expressionButton.imageSize = CGSizeMake(45.f, 45.f);
    [self.expressionButton addTarget:self action:@selector(__showExpressionForTime) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.expressionButton];
}
- (void)__showExpressionForTime{
    CGPoint point = self.expressionButton.center;
    UIImage *image = nil;
    while (!image) {
        int index = rand()%221;
        NSString *imageName = [NSString stringWithFormat:@"%dfix.png",index];
        image = [UIImage imageNamed_lwlab:imageName];
    }
    [self touchesWithImage:image point:point];
}
- (void)setIsBegin:(BOOL)isBegin{
    _isBegin = isBegin;
    [self _loadView];
}
- (void)_rightBarButtonItemAction:(id)sender{
    self.isBegin = !self.isBegin;
}
- (void)_loadView{
    NSString *title;
    if (self.isBegin) {
        title = @"结束";
        [self.timer setFireDate:[NSDate date]];
    }else{
        title = @"开始";
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    self.navigationItem.rightBarButtonItem.title = title;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}
- (void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    //
    CGRect f1 = bounds;
    f1.size = [self.expressionButton sizeThatFits:CGSizeZero];
    f1.origin.x = bounds.size.width - f1.size.width - 50.f;
    f1.origin.y = bounds.size.height - f1.size.height - 50.f;
    self.expressionButton.frame = f1;
}
#pragma mark - touch
- (void)touchesWithImage:(UIImage *)image point:(CGPoint )point{
    [LWUILaunchExpressionView showExpressionWithImage:image sourcePoint:point];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    UITouch * touch = touches.anyObject;//获取触摸对象
    CGPoint point = [touch locationInView:self.view];
    //
    UIImage *image = [UIImage imageNamed_lwlab:@"lwlab_icon.png"];
    image = [UIImage compressOriginalImage:image toSize:CGSizeMake(45.f, 45.f)];
    [self touchesWithImage:image point:point];
}
@end
