//
//  NSError+Message.m
//  LWApiMessage
//
//  Created by 程恒盛 on 17/1/19.
//  Copyright © 2017年 力王. All rights reserved.
//

#import "NSError+Message.h"

NSString *const kLWMessageErrorDomain=@"com.chenghengsheng.error.message";

@implementation NSError (Message)
+ (NSError *)errorWithMessageCode:(NSInteger)code errorMsg:(NSString *)msg{
    NSError *error = [NSError errorWithDomain:kLWMessageErrorDomain code:code userInfo:@{NSLocalizedFailureReasonErrorKey:msg?:@""}];
    return error;
}
@end
