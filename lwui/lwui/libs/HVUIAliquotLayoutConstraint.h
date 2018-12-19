//
//  HVUIAliquotLayoutConstraint.h
//  hvui
//	在水平或垂直方向上等分布局的约束,每个元素的尺寸是一样的
//  Created by moon on 15/4/14.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUILayoutConstraint.h"

@interface HVUIAliquotLayoutConstraint : HVUILayoutConstraint{
}
@property(nonatomic,assign) HVUILayoutConstraintDirection layoutDirection;//布局方向
@property(nonatomic,assign) UIEdgeInsets contentInsets;//内边距,默认为(0,0,0,0)
@property(nonatomic,assign) CGFloat interitemSpacing;//元素间的间隔,默认为0
+ (void)aliquotLayoutWithItems:(NSArray<id<HVUILayoutConstraintItemProtocol>> *)items bounds:(CGRect)bounds layoutDirection:(HVUILayoutConstraintDirection)layoutDirection;
- (void)layoutItemsWithHidden:(BOOL)layoutHiddenItem;//布局时,是否把隐藏元素考虑进去
@end
/**
 *
 HVUILayoutConstraintDirectionVertical:
 items:A~D
 ___
|_A_|
|_B_|
|_C_|
|_D_|
 
 HVUILayoutConstraintDirectionHorizontal:
 items:A~D
 _______________
|_A_|_B_|_C_|_D_|
 */
