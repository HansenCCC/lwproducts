//
//  LWFormImageViewCell.h
//  lwui
//  根据图片大小动态高度
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormViewCell.h"

@interface LWFormImageViewCell : LWFormViewCell
AS_SINGLETON(LWFormImageViewCell)//用于计算动态高度
@property(nonatomic,strong) UIImageView *elementImageView;

@end
