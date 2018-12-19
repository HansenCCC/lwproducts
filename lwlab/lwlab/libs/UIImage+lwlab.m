//
//  UIImage+lwlab.m
//  lwlab
//
//  Created by 程恒盛 on 2018/3/16.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "UIImage+lwlab.h"
#import "NSBundle+lwlab.h"

@implementation UIImage (lwlab)
+ (UIImage *)imageNamed_lwlab:(NSString *)name{
    NSBundle *bundle = [NSBundle lwlabBundle];
    UIImage *image = [UIImage imageWithName:name forBundle:bundle];
    return image;
}
@end
