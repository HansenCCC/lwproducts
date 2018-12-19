//
//  LWLabAppIconMakerViewController.h
//  lwlab
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabViewController_Basic.h"

@interface LWLabAppIconMakerViewController : LWUITableViewController
@property(nonatomic,strong) UIImage *iconImage;
@property(nonatomic,strong) NSString *iconPath;
- (id)initWithIconImage:(UIImage *)iconImage;
@end
