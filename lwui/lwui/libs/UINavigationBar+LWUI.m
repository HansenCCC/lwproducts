//
//  UINavigationBar+LWUI.m
//  lwui
//
//  Created by Herson on 17/2/8.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "UINavigationBar+LWUI.h"

@implementation UINavigationBar (LWUI)
-(UIView *)barBackground{
    UIView *barBackground;
    for (UIView *view in self.subviews) {
        if([view isKindOfClass:NSClassFromString(@"_UIBarBackground")])
        {
            barBackground = view;
        }
    }
    return barBackground;
}
@end
