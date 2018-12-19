//
//  NSError+Message.h
//  LWApiMessage
//
//  Created by 程恒盛 on 17/1/19.
//  Copyright © 2017年 力王. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kLWMessageErrorDomain;

@interface NSError (Message)

/**
 自定义消息错误

 @param code err code
 @param msg 信息
 @return nserror
 */
+ (NSError *)errorWithMessageCode:(NSInteger)code errorMsg:(NSString *)msg;
@end
