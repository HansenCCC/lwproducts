//
//  NSBundle+lwlab.h
//  lwlab
//
//  Created by 程恒盛 on 2018/3/16.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <Foundation/Foundation.h>

//获取LWUIBundle多语
#define NSLocalizedString_lwlab(key, comment) \
[[NSBundle lwlabBundle] localizedStringForKey:(key) value:@"" table:nil]

@interface NSBundle (lwlab)

+ (NSBundle *)lwlabBundle;

@end
