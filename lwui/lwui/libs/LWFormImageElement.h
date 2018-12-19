//
//  LWFormImageElement.h
//  lwui
//
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormElement.h"

@interface LWFormImageElement : LWFormElement
@property (strong, nonatomic) UIImage *image;
- (id)initWithTitle:(NSString *)title image:(UIImage *)image;
@end
