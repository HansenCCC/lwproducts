//
//  LWImageCache.m
//  LWUI
//
//  Created by 程恒盛 on 17/3/29.
//  Copyright © 2017年 Herson. All rights reserved.
//

#import "LWImageCache.h"
#import "UIImageView+WebCache.h"
#import "UIView+WebCache.h"
#import "SDImageCache.h"


@implementation LWImageCache
DEF_SINGLETON(LWImageCache)
-(void)clearMemory:(LWImageNoParamsBlock) completion{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:completion];
}
- (CGFloat)checkTmpSize{
     return [[SDImageCache sharedImageCache] checkTmpSize];
}
@end
