//
//  LWImageCache.h
//  LWUI
//
//  Created by 程恒盛 on 17/3/29.
//  Copyright © 2017年 Herson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LWDefine.h"
#import <UIKit/UIKit.h>

typedef void(^LWImageNoParamsBlock)(void);

@interface LWImageCache : NSObject
AS_SINGLETON(LWImageCache);

#pragma mark - Cache clean Ops

/**
 清楚所有缓存 Clear all memory cached images

 @param completion 完成回调
 */
-(void)clearMemory:(LWImageNoParamsBlock) completion;

/**
 获取当前所有加载图片内存 Get the number of images in the disk cache

 @return 内存
 */
- (CGFloat)checkTmpSize;
@end
