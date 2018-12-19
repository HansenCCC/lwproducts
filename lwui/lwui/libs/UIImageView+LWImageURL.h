//
//  UIImageView+LWImageURL.h
//  LWUI
//  介于当今流行的加载网络图片第三方sdw，进行封装 若要更换其他框架修改其实现方法即可
//  Created by 程恒盛 on 17/2/7.
//  Copyright © 2017年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^LWImageDownloaderProgressBlock)(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL);//定义进度回调
typedef void(^LWExternalCompletionBlock)(UIImage * _Nullable image, NSError * _Nullable error, NSURL * _Nullable imageURL);//定义完成回调
@interface UIImageView (LWImageURL)

/**
 请求网络图片

 @param url 图片地址
 */
- (void)setImageWithURL:(nullable NSURL *)url;

/**
 请求网络图片

 @param url         图片地址
 @param placeholder 未加载前图片
 */
- (void)setImageWithURL:(nullable NSURL *)url
       placeholderImage:(nullable UIImage *)placeholder;

/**
 请求网络图片

 @param url            图片地址
 @param placeholder    未加载前图片
 @param completedBlock 完成回调
 */
- (void)setImageWithURL:(nullable NSURL *)url
       placeholderImage:(nullable UIImage *)placeholder
              completed:(nullable LWExternalCompletionBlock)completedBlock;

/**
 请求网络图片

 @param url            图片地址
 @param placeholder    未加载前图片
 @param progressBlock  进度回调
 @param completedBlock 完成回调
 */
- (void)setImageWithURL:(nullable NSURL *)url
          placeholderImage:(nullable UIImage *)placeholder
                  progress:(nullable LWImageDownloaderProgressBlock)progressBlock
                 completed:(nullable LWExternalCompletionBlock)completedBlock;
@end
