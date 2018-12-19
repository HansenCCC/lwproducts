//
//  UIImageView+LWUI.m
//  lwui
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "UIImageView+LWUI.h"
#import "UIImage+LWUI.h"

@implementation UIImageView (LWUI)
- (CGSize)sizeThatFitsToMaxSize:(CGSize)size{
    if (self.image) {
        CGSize resize = [self.image sizeWithMaxRelativeSize:size];
        if (resize.width > self.image.size.width) {
            return self.image.size;
        }
        return resize;
    }
    return [super sizeThatFitsToMaxSize:size];
}
@end
