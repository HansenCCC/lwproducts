//
//  UIButton+LWImageURL.h
//  LWUI
//  介于当今流行的加载网络图片第三方sdw，进行封装 若要更换其他框架修改其实现方法即可
//  Created by 程恒盛 on 17/2/7.
//  Copyright © 2017年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+LWImageURL.h"
@interface UIButton (LWImageURL)

/**
 请求网络图片（UIButton）
 
 @param url            图片地址
 @param state          按钮状态
 */
- (void)setImageWithURL:(nullable NSURL *)url
               forState:(UIControlState)state;
/**
 请求网络图片（UIButton）
 
 @param url            图片地址
 @param state          按钮状态
 @param placeholder    未加载是显示图片
 */
- (void)setImageWithURL:(nullable NSURL *)url
               forState:(UIControlState)state
       placeholderImage:(nullable UIImage *)placeholder;
/**
 请求网络图片（UIButton）

 @param url            图片地址
 @param state          按钮状态
 @param placeholder    未加载是显示图片
 @param completedBlock 完成回调
 */
- (void)setImageWithURL:(nullable NSURL *)url
                  forState:(UIControlState)state
          placeholderImage:(nullable UIImage *)placeholder
                 completed:(nullable LWExternalCompletionBlock)completedBlock;
@end
