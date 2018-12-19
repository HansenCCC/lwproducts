//
//  NSBundle+LWUI.h
//  lwui
//
//  Created by Herson on 17/2/8.
//  Copyright © 2018年 力王. All rights reserved.
//

#import <Foundation/Foundation.h>
//获取LWUIBundle多语
#define NSLocalizedString_LW(key, comment) \
[[NSBundle lwuiBundle] localizedStringForKey:(key) value:@"" table:nil]

@interface NSBundle (LWUI)
+ (NSBundle *)lwuiBundle;

@end

