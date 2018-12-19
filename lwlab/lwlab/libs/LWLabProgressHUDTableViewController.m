//
//  LWLabProgressHUDTableViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/27.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabProgressHUDTableViewController.h"

@interface LWLabProgressHUDTableViewController ()
@property(nonatomic, strong) LWFormElement *textProgressHUDModel;//文本
@property(nonatomic, strong) LWFormElement *textTapHideProgressHUDModel;//文本点击隐藏
@property(nonatomic, strong) LWFormElement *lodingProgressHUDModel;//加载
@property(nonatomic, strong) LWFormElement *progressHUDModel;//进度
@property(nonatomic, strong) LWFormElement *iconProgressHUDModel;//icon
@property(nonatomic, strong) LWFormElement *successProgressHUDModel;//success
@property(nonatomic, strong) LWFormElement *failProgressHUDModel;//fail

@property(nonatomic, strong) NSTimer *timer;
@end

@implementation LWLabProgressHUDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"LWProgressHUD";
    
    [self reloadDatas];
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
- (void)reloadDatas{
    [self.model removeAllSections];
    [self.model addCellModel:self.textProgressHUDModel];
    [self.model addCellModel:self.textTapHideProgressHUDModel];
    [self.model addCellModel:self.lodingProgressHUDModel];
    [self.model addCellModel:self.progressHUDModel];
    [self.model addCellModel:self.iconProgressHUDModel];
    [self.model addCellModel:self.successProgressHUDModel];
    [self.model addCellModel:self.failProgressHUDModel];
    [self.model reloadTableViewBackgroundView];
}
- (LWFormElement *)textProgressHUDModel{
    if (!_textProgressHUDModel) {
        @HV_WEAKIFY(self);
        _textProgressHUDModel = [[LWFormElement alloc] initWithTitle:@"文本提示2s后自动隐藏"];
        _textProgressHUDModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            [self.view showTipWithTitle:@"展示一条文本提示框" detail:@"2s后自动隐藏" animated:YES afterDelay:2];
        };
    }
    return _textProgressHUDModel;
}
- (LWFormElement *)textTapHideProgressHUDModel{
    if (!_textTapHideProgressHUDModel) {
        @HV_WEAKIFY(self);
        _textTapHideProgressHUDModel = [[LWFormElement alloc] initWithTitle:@"文本提示点击隐藏"];
        _textTapHideProgressHUDModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            [self.view showTipWithTitle:@"展示一条文本提示框," detail:@"点击隐藏" animated:YES];
            [self.view.progressHUD addHideGesture];
        };
    }
    return _textTapHideProgressHUDModel;
}
- (LWFormElement *)lodingProgressHUDModel{
    if (!_lodingProgressHUDModel) {
        @HV_WEAKIFY(self);
        _lodingProgressHUDModel = [[LWFormElement alloc] initWithTitle:@"加载提示2s后自动隐藏"];
        _lodingProgressHUDModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            [self.view showLodingWithTitle:@"2s后自动隐藏" animated:YES];
            [self.view autoHideProgressInfoView:YES];
        };
    }
    return _lodingProgressHUDModel;
}
- (LWFormElement *)progressHUDModel{
    if (!_progressHUDModel) {
        @HV_WEAKIFY(self);
        _progressHUDModel = [[LWFormElement alloc] initWithTitle:@"进度提示加载完成自动隐藏"];
        _progressHUDModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            [self.view showProgressWithTitle:@"显示进度条，加载完成自动隐藏" animated:YES];
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(__incrementingProgress) userInfo:nil repeats:YES];
        };
    }
    return _progressHUDModel;
}
- (void)__incrementingProgress{
    LWProgressHUD *hud = self.view.progressHUD;
    if(hud.progress>=1){
        [self.view showSuccessWithTitle:@"成功显示" detail:@"2s后自动隐藏"];
        [self.view autoHideProgressInfoView:YES];
        [self.timer invalidate];
        self.timer = nil;
        return;
    }
    hud.progress = hud.progress + 0.01;
}
- (LWFormElement *)iconProgressHUDModel{
    if (!_iconProgressHUDModel) {
        @HV_WEAKIFY(self);
        _iconProgressHUDModel = [[LWFormElement alloc] initWithTitle:@"icon提示2s后自动隐藏"];
        _iconProgressHUDModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            UIImage *image = [UIImage imageNamed_lwlab:@"lwlab_icon.png"];
            image = [UIImage compressOriginalImage:image toSize:CGSizeMake(45.f, 45.f)];
            [self.view showWithTitle:@"icon提示" detail:@"2s后自动隐藏" icon:image];
            [self.view autoHideProgressInfoView:YES];
        };
    }
    return _iconProgressHUDModel;
}
- (LWFormElement *)successProgressHUDModel{
    if (!_successProgressHUDModel) {
        @HV_WEAKIFY(self);
        _successProgressHUDModel = [[LWFormElement alloc] initWithTitle:@"成功提示2s后自动隐藏"];
        _successProgressHUDModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            [self.view showSuccessWithTitle:@"成功显示" detail:@"2s后自动隐藏"];
            [self.view autoHideProgressInfoView:YES];
        };
    }
    return _successProgressHUDModel;
}
- (LWFormElement *)failProgressHUDModel{
    if (!_failProgressHUDModel) {
        @HV_WEAKIFY(self);
        _failProgressHUDModel = [[LWFormElement alloc] initWithTitle:@"失败提示2s后自动隐藏"];
        _failProgressHUDModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
            @HV_NORMALIZEANDNOTNIL(self);
            [self.view showFailWithTitle:@"失败显示" detail:@"2s后自动隐藏"];
            [self.view autoHideProgressInfoView:YES];
        };
    }
    return _failProgressHUDModel;
}
@end
