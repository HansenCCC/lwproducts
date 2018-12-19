//
//  LWLabInputImageTableViewCellModel.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/18.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabInputImageTableViewCellModel.h"
#import "LWLabInputImageTableViewCell.h"

@implementation LWLabInputImageTableViewCellModel
- (instancetype)init{
    if(self = [super init]){
        self.cellClass = [LWLabInputImageTableViewCell class];
    }
    return self;
}
- (UIImage *)originIconImage{
    UIImage *image = nil;
    if([[NSFileManager defaultManager] fileExistsAtPath:self.filePath]){
        image = [[UIImage alloc] initWithContentsOfFile:self.filePath];
    }
    return image;
}
- (UIImage *)iconImage{
    if(!_iconImage){
        _iconImage = self.originIconImage;
    }
    return _iconImage;
}
- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    [self refreshWithAnimated:YES];
}
@end
