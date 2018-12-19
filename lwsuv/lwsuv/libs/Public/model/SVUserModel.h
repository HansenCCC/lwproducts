//
//  SVUserModel.h
//  CHHomeDec
//  用户信息
//  Created by 程恒盛 on 2018/8/28.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVUserModel : NSObject
@property (nonatomic, strong) NSString *account;//账号
@property (nonatomic, strong) NSString *code;//密码
@property (nonatomic, strong) NSString *name;//名称
@property (nonatomic, strong) NSString *token;//token

@end
