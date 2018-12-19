//
//  LWLabAppIconMakerViewController.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabAppIconMakerViewController.h"
#import "LWAppIcon.h"

@interface LWLabAppIconMakerViewController ()
@property (strong, nonatomic) NSArray <LWAppIcon *>*appIcons;
@end

@implementation LWLabAppIconMakerViewController
- (id)initWithIconImage:(UIImage *)iconImage{
    if(self = [self init]){
        self.iconImage = iconImage;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.appIcons = [LWAppIcon appIconListWithOriginImage:self.iconImage];
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(__onSaveButtonDidTap:)];
    self.navigationItem.rightBarButtonItem = saveItem;
    [self reloadDatas];
}
- (void)__onSaveButtonDidTap:(id)sender{
    NSString *dirPath = [self.iconPath stringByDeletingLastPathComponent];
    for (LWAppIcon *appIcon in self.appIcons) {
        [appIcon saveToDir:dirPath];
    }
    [LWAppIcon saveContentJsonToDir:dirPath];
}
- (void)reloadDatas{
    [self.model removeAllSections];
    //code
    for (LWAppIcon *appIcon in self.appIcons) {
        LWFormImageElement *element = [[LWFormImageElement alloc] initWithTitle:appIcon.name image:appIcon.scaledImage];
        [self.model addCellModel:element];
    }
    [self.model reloadTableViewData];
}
@end
