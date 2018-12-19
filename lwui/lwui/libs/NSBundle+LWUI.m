//
//  NSBundle+LWUI.m
//  lwui
//
//  Created by Herson on 17/2/8.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "NSBundle+LWUI.h"

@implementation NSBundle (LWUI)
+ (NSBundle *)lwuiBundle{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"lwuiBundle" ofType:@"bundle"]];
    return bundle;
}
@end
