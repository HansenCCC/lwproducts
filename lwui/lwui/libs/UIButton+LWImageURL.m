//
//  UIButton+LWImageURL.m
//  LWUI
//
//  Created by 程恒盛 on 17/2/7.
//  Copyright © 2017年 Herson. All rights reserved.
//

#import "UIButton+LWImageURL.h"
#import "UIButton+WebCache.h"
#import "UIView+WebCache.h"

@implementation UIButton (LWImageURL)
- (void)setImageWithURL:(nullable NSURL *)url
               forState:(UIControlState)state{
    [self setImageWithURL:url forState:state placeholderImage:nil completed:nil];
}
- (void)setImageWithURL:(nullable NSURL *)url
               forState:(UIControlState)state
       placeholderImage:(nullable UIImage *)placeholder{
    [self setImageWithURL:url forState:state placeholderImage:placeholder completed:nil];
}
- (void)setImageWithURL:(nullable NSURL *)url
               forState:(UIControlState)state
       placeholderImage:(nullable UIImage *)placeholder
              completed:(nullable LWExternalCompletionBlock)completedBlock{
    if (!url) {
        [self.imageURLStorage removeObjectForKey:@(state)];
        return;
    }
    self.imageURLStorage[@(state)] = url;
    SDExternalCompletionBlock sdwCompletionBlock = nil;
    if (completedBlock) {
        sdwCompletionBlock = ^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL){
            completedBlock(image,error,imageURL);
        };
    }
    __weak typeof(self)weakSelf = self;
    [self sd_internalSetImageWithURL:url
                    placeholderImage:placeholder
                             options:0
                        operationKey:[NSString stringWithFormat:@"UIButtonImageOperation%@", @(state)]
                       setImageBlock:^(UIImage *image, NSData *imageData) {
                           [weakSelf setImage:image forState:state];
                       }
                            progress:nil
                           completed:sdwCompletionBlock];
}
@end
