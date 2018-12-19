//
//  UIImageView+LWImageURL.m
//  LWUI
//
//  Created by 程恒盛 on 17/2/7.
//  Copyright © 2017年 Herson. All rights reserved.
//

#import "UIImageView+LWImageURL.h"
#import "UIImageView+WebCache.h"
#import "UIView+WebCache.h"

@implementation UIImageView (LWImageURL)

-(void)setImageWithURL:(NSURL *)url{
    [self setImageWithURL:url placeholderImage:nil progress:nil completed:nil];
}
-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder{
    [self setImageWithURL:url placeholderImage:placeholder progress:nil completed:nil];
}
-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(LWExternalCompletionBlock)completedBlock{
    [self setImageWithURL:url placeholderImage:placeholder progress:nil completed:completedBlock];
}
-(void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder progress:(LWImageDownloaderProgressBlock)progressBlock completed:(LWExternalCompletionBlock)completedBlock{
    /*  嵌套
     SDWebImageDownloaderProgressBlock sdwProgressBlock;
     if (progressBlock){
     sdwProgressBlock = ^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL){
     progressBlock(receivedSize,expectedSize,targetURL);
     };
     }
     SDExternalCompletionBlock sdwCompletionBlock;
     if (completedBlock) {
     sdwCompletionBlock = ^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL){
     completedBlock(image,error,imageURL);
     };
     }
     [self sd_setImageWithURL:url placeholderImage:placeholder options:0 progress:sdwProgressBlock completed:sdwCompletionBlock];
     */
    
    SDExternalCompletionBlock sdwCompletionBlock = nil;
    if (completedBlock) {
        sdwCompletionBlock = ^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL){
            completedBlock(image,error,imageURL);
        };
    }
    [self sd_internalSetImageWithURL:url
                    placeholderImage:placeholder
                             options:0
                        operationKey:nil
                       setImageBlock:nil
                            progress:progressBlock
                           completed:sdwCompletionBlock];
}

@end
