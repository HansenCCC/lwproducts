//
//  NSBundle+lwlab.m
//  lwlab
//
//  Created by 程恒盛 on 2018/3/16.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "NSBundle+lwlab.h"

@implementation NSBundle (lwlab)
+ (NSBundle *)lwlabBundle{
    NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"lwlab" ofType:@"bundle"]];
    return bundle;
}
@end
