//
//  LWApiMessage.h
//  LWApi
//
//  Created by 程恒盛 on 17/1/20.
//  Copyright © 2017年 力王. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <lwui/lwui.h>

typedef NSURLSessionTask *(^LWAPIMessageN)(NSString *url);

@interface LWApiMessage : LWMessage{
    NSDictionary *_parameters;
}

@property(nonatomic, readonly) NSURLSessionTask *sessionTask;

@property(nonatomic, strong) NSDictionary *parameters;
@property(nonatomic, strong) NSData *fromData;
@property(nonatomic, assign) NSTimeInterval timeoutInterval;//设置超时时间，默认为 10s
@property(nonatomic, readonly) LWAPIMessageN HTTP;//生成POST的请求,
@property(nonatomic, readonly) LWAPIMessageN HTTP_GET;//生成get的http请求,
@property(nonatomic, readonly) LWAPIMessageN HTTP_POST;//生成get的http请求,
@property(nonatomic, readonly) LWAPIMessageN HTTP_DOWNLOAD;//生成下载文件的get的http请求
@property(nonatomic, readonly) id responseObject;//请求到data数据
@property(nonatomic, strong) NSString *defalueFileName;//下载文件文件名，为空时为默认名字
@property(nonatomic, readonly) LWAPIMessageN HTTP_UPLOAD;//生成上传文件的post的http请求
//默认下载地址
-(NSString *)defalueCachesPath;

- (void)suspend;
- (void)resume;
@end
