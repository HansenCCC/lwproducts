//
//  LWLabSegmentedViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/5/2.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabSegmentedViewController.h"
#import "LWLabSegmentedCollectionViewCellModel.h"

@interface LWLabSegmentedViewController ()
@property (strong, nonatomic) LWUISegmentedView *segmentedView;

@end

@implementation LWLabSegmentedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"仿凤凰新闻频道列表";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.segmentedView = [[LWUISegmentedView alloc] init];
    self.segmentedView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.segmentedView];
    
    [self reloadDatas];
}
- (void)reloadDatas{
    [self.segmentedView removeAllSections];
    for (NSString *title in [UIFont familyNames]) {
        LWLabSegmentedCollectionViewCellModel *cm = [[LWLabSegmentedCollectionViewCellModel alloc] initWithTitle:title];
        @HV_WEAKIFY(self);
        cm.selected = [title isEqualToString:[UIFont familyNames].firstObject];
        cm.whenClick = ^(__kindof HVUICollectionViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            [self.segmentedView didSelectItemAtCellModel:cellModel];
        };
        [self.segmentedView addSegmentedModel:cm];
    }
    [self.segmentedView reloadSegmentedViewData];
}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect bounds = self.view.bounds;
    UIEdgeInsets insets = UIEdgeInsetsZero;
    if (@available(iOS 11.0, *)) {
        insets = self.view.safeAreaInsets;
    }else{
        insets = self.ios11belowSafeAreaInsets;
    }
    bounds = UIEdgeInsetsInsetRect(bounds,insets);
    CGRect f1 = bounds;
    f1.size.height = 45.f;
    self.segmentedView.frame = f1;
}
@end
