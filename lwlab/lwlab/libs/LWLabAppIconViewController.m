//
//  LWLabAppIconViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/11.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabAppIconViewController.h"
#import "LWLabAppIconMakerViewController.h"//icon列表
#import "LWLabInputImageTableViewCellModel.h"
#import "LWLabAppIconImageView.h"

@interface LWLabAppIconViewController ()
@property(nonatomic, strong) LWLabInputImageTableViewCellModel *inputImageModel;
@property(nonatomic, strong) LWFormElement *betaTitleModel;
@property(strong, nonatomic) LWFormSelectOneElement *selectColorElement;
@property(strong, nonatomic) LWFormSelectOneElement *selectBackgroundColorElement;
@property(strong, nonatomic) LWFormButtonElement *addBetaButtonElement;
@property(strong, nonatomic) LWFormButtonElement *makerIconButtonElement;

@end

@implementation LWLabAppIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"App图标制作";
    //
    if (@available(iOS 11.0, *)) {
    } else {
        // Fallback on earlier versions
        //iOS 11之前消除head多出空白
        self.tableView.tableHeaderView = UITableViewHeaderViewLWStuff;
    }
}
- (void)reloadDatas{
    [self.model removeAllSections];
    //code
    [self.model addCellModel:self.inputImageModel];
    [self.model addCellModel:self.betaTitleModel];
    [self.model addCellModel:self.selectColorElement];
    [self.model addCellModel:self.selectBackgroundColorElement];
    [self.model addCellModel:self.addBetaButtonElement];
    [self.model addCellModel:self.makerIconButtonElement];
    
    [self.model reloadTableViewData];
}
-(LWLabInputImageTableViewCellModel *)inputImageModel{
    if (!_inputImageModel) {
        _inputImageModel = [[LWLabInputImageTableViewCellModel alloc] init];
        _inputImageModel.filePath = @"";
    }
    return _inputImageModel;
}
-(LWFormElement *)betaTitleModel{
    if (!_betaTitleModel) {
        _betaTitleModel = [[LWFormTextFieldElement alloc] initWithTitle:@"Beta文字"];
        _betaTitleModel.name = @"Beta";
    }
    return _betaTitleModel;
}
-(LWFormSelectOneElement *)selectColorElement{
    if (!_selectColorElement) {
        _selectColorElement = [[LWFormSelectOneElement alloc] initWithTitle:@"Beta文字颜色"];
        _selectColorElement.cellClass = [LWFormSelectColorViewCell class];
        NSDictionary *colors = [UIColor commonColors];
        NSString *defaultColor = @"whiteColor";
        for (NSString *colorName in colors.allKeys) {
            BOOL select = [colorName isEqualToString:defaultColor];
            [_selectColorElement addOption:colors[colorName] desc:colorName selected:select];
        }
        _selectColorElement.placeholder = @"color";
    }
    return _selectColorElement;
}
-(LWFormSelectOneElement *)selectBackgroundColorElement{
    if (!_selectBackgroundColorElement) {
        _selectBackgroundColorElement = [[LWFormSelectOneElement alloc] initWithTitle:@"Beta背景颜色"];
        _selectBackgroundColorElement.cellClass = [LWFormSelectColorViewCell class];
        NSDictionary *colors = [UIColor commonColors];
        NSString *defaultColor = @"redColor";
        for (NSString *colorName in colors.allKeys) {
            BOOL select = [colorName isEqualToString:defaultColor];
            [_selectBackgroundColorElement addOption:colors[colorName] desc:colorName selected:select];
        }
        _selectBackgroundColorElement.placeholder = @"color";
    }
    return _selectBackgroundColorElement;
}
- (LWFormButtonElement *)addBetaButtonElement{
    if (!_addBetaButtonElement) {
        @HV_WEAKIFY(self);
        _addBetaButtonElement = [[LWFormButtonElement alloc] initWithTitle:@"添加Beta" whenClick:^(LWFormButtonElement *element) {
            [element deselectCellWithAnimated:YES];
            @HV_NORMALIZEANDNOTNIL(self);
            UIImage *iconImage = [LWLabAppIconImageView imageWithImage:self.inputImageModel.originIconImage text:self.betaTitleModel.name textColor:(UIColor *)self.selectColorElement.selectedKey textBackgroundColor:(UIColor *)self.selectBackgroundColorElement.selectedKey];
            self.inputImageModel.iconImage = iconImage;
        }];
    }
    return _addBetaButtonElement;
}
- (LWFormButtonElement *)makerIconButtonElement{
    if (!_makerIconButtonElement) {
        @HV_WEAKIFY(self);
        _makerIconButtonElement = [[LWFormButtonElement alloc] initWithTitle:@"制作App图标" whenClick:^(LWFormButtonElement *element) {
            @HV_NORMALIZEANDNOTNIL(self);
            [self.view endEditing:YES];
            [element deselectCellWithAnimated:YES];
            LWLabAppIconMakerViewController *controller = [[LWLabAppIconMakerViewController alloc] initWithIconImage:self.inputImageModel.iconImage];
            controller.iconPath = self.inputImageModel.filePath;
            [self.navigationController pushViewController:controller animated:YES];
        }];
    }
    return _makerIconButtonElement;
}
@end
