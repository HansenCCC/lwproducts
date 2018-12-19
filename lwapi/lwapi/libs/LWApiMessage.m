//
//  LWApiMessage.m
//  LWApi
//
//  Created by 程恒盛 on 17/1/20.
//  Copyright © 2017年 力王. All rights reserved.
//

#import "LWApiMessage.h"
#import "AFNetworking.h"

@interface LWApiMessage ()
@property(nonatomic, strong) AFHTTPSessionManager *manager;
@property(nonatomic, strong) NSURLSessionTask *sessionTask;

@end

@implementation LWApiMessage
-(instancetype)init{
    if (self = [super init]) {
        //监听网络状态变更
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(__ReachabilityDidChangeNotification:) name:AFNetworkingReachabilityDidChangeNotification object:nil];
        self.timeoutInterval = 10.f;
    }
    return self;
}
//
-(void)__ReachabilityDidChangeNotification:(NSNotification *)notification{
    [[AFNetworkReachabilityManager sharedManager]setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus allstatus) {
        switch (allstatus) {
            case AFNetworkReachabilityStatusNotReachable:{
                //无网络
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                //WiFi
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:{
                //3G
                break;
            }
            default:
                break;
        }
    }];
}
//POST GET 请求
- (NSURLSessionTask *)addRequestWithUrl:(NSString *)url method:(NSString *)method{
    [self cancelAllRequest];//关闭任务中没有完成的任务
    
    @HV_WEAKIFY(self);
    void (^downloadProgress)(NSProgress *downloadProgress) = ^(NSProgress *downloadProgress){
        @HV_NORMALIZE(self);
        //获取当前下载进度
        self.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
    };
    void (^uploadProgress)(NSProgress *uploadProgress) = ^(NSProgress *uploadProgress){
        @HV_NORMALIZE(self);
        //获取当前上传进度
        self.progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
    };
    void (^success)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask *dataTask, id responseObject){
        @HV_NORMALIZE(self);
        _responseObject = responseObject;
        self.succeed = YES;
    };
    void (^failure)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *dataTask, NSError *error){
        @HV_NORMALIZE(self);
        _error = error;
        self.failed = YES;
    };

    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
    manager.requestSerializer.timeoutInterval = _timeoutInterval;
    NSURLSessionDataTask *dataTask = [manager dataTaskWithHTTPMethod:method URLString:url parameters:self.parameters uploadProgress:uploadProgress downloadProgress:downloadProgress success:success failure:failure];
    self.manager = manager;
    self.sessionTask = dataTask;
    [self resume];//开始请求
    return dataTask;
}
//封装上传方法  （-warn 该方法并未测试，可能存在问题）
-(NSURLSessionTask *)uploadTaskRequestWithUrl:(NSString *)url{
    [self cancelAllRequest];//关闭任务中没有完成的任务
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    @HV_WEAKIFY(self);
    if (!self.fromData) {
        self.failed = YES;
        return nil;
    }
    
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithRequest:request fromData:self.fromData progress:^(NSProgress * _Nonnull uploadProgress) {
        @HV_NORMALIZE(self);
        //获取下载进度
        self.progress = 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount;
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        //responseObject 返回结果
        if (error) {
            _error = error;
            self.failed = YES;
        }else{
            _responseObject = responseObject;
            self.succeed = YES;
        }
    }];
    
    self.manager = manager;
    self.sessionTask = uploadTask;

    [uploadTask resume];
    return uploadTask;
}

//封装下载方法
-(NSURLSessionTask *)downloadTaskRequestWithUrl:(NSString *)url{
    [self cancelAllRequest];//关闭任务中没有完成的任务
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    @HV_WEAKIFY(self);
    //下载Task操作
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        @HV_NORMALIZE(self);
        //获取下载进度
        self.progress = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        @HV_NORMALIZE(self);
        //返回一个文件位置的路径
        NSString *cachesPath = [self defalueCachesPath];
        NSString *fileName = _defalueFileName?_defalueFileName:response.suggestedFilename;
        NSString *path = [cachesPath stringByAppendingPathComponent:fileName];
        return [NSURL fileURLWithPath:path];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        @HV_NORMALIZE(self);
        // filePath 文件地址
        if (error) {
            _error = error;
            self.failed = YES;
        }else{
            _responseObject = filePath;
            self.succeed = YES;
        }
    }];
    self.manager = manager;
    self.sessionTask = downloadTask;
    
    [downloadTask resume];
    return downloadTask;
}

-(LWAPIMessageN)HTTP{
    return [self HTTP_POST];
}
-(LWAPIMessageN)HTTP_POST{
    @HV_WEAKIFY(self);
    LWAPIMessageN blockN = ^NSURLSessionTask *(NSString *url){
        @HV_NORMALIZE(self);
        return [self addRequestWithUrl:url method:@"POST"];
    };
    return [blockN copy];
}
-(LWAPIMessageN)HTTP_GET{
    @HV_WEAKIFY(self);
    LWAPIMessageN blockN = ^NSURLSessionTask *(NSString *url){
        @HV_NORMALIZE(self);
        return [self addRequestWithUrl:url method:@"GET"];
    };
    return [blockN copy];
}
-(LWAPIMessageN)HTTP_DOWNLOAD{
    @HV_WEAKIFY(self);
    LWAPIMessageN blockN = ^NSURLSessionTask *(NSString *url){
        @HV_NORMALIZE(self);
        return [self downloadTaskRequestWithUrl:url];
    };
    return [blockN copy];
}
-(LWAPIMessageN)HTTP_UPLOAD{
    @HV_WEAKIFY(self);
    LWAPIMessageN blockN = ^NSURLSessionTask *(NSString *url){
        @HV_NORMALIZE(self);
        return [self uploadTaskRequestWithUrl:url];
    };
    return [blockN copy];
}


-(void)dealloc{
    [self cancelAllRequest];
}
-(void)cancelAllRequest{//消除请求防止crash
    [self.manager.operationQueue cancelAllOperations];
    [self.manager.session invalidateAndCancel];
    [self.sessionTask cancel];
    self.sessionTask = nil;
    self.manager = nil;
}

-(NSString *)defalueCachesPath{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return cachesPath;
}

#pragma mark - override method
-(void)setSucceed:(BOOL)succeed{
    [super setSucceed:succeed];
    [self cancelAllRequest];
}
-(void)setFailed:(BOOL)failed{
    [super setFailed:failed];
    [self cancelAllRequest];
}
-(void)setCancelled:(BOOL)cancelled{
    [super setCancelled:cancelled];
    [self cancelAllRequest];
}
-(void)cancel{
    [self cancelAllRequest];
    [super cancel];
}
-(void)suspend{
    [self.sessionTask suspend];
}
-(void)resume{
    [self.sessionTask resume];
}
@end
