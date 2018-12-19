//
//  LWLabInputImageTableViewCellModel.h
//  lwlab
//
//  Created by 程恒盛 on 2018/4/18.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWLabInputImageTableViewCellModel : HVTableViewCellModel{
    UIImage *_iconImage;
}
@property(strong, nonatomic) NSString *filePath;
@property(strong, nonatomic) UIImage *iconImage;
@property(nonatomic,readonly) UIImage *originIconImage;
@end
