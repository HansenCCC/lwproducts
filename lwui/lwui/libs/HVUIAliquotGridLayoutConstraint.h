//
//  HVUIAliquotGridLayoutConstraint.h
//  hvui
//	等分的网格布局约束,每个元素的尺寸一样
//  Created by moon on 15/4/14.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUILayoutConstraint.h"

@interface HVUIAliquotGridLayoutConstraint : HVUILayoutConstraint
@property(nonatomic,assign) NSUInteger numberOfRows;//行数
@property(nonatomic,assign) NSUInteger numberOfCols;//列数
@property(nonatomic,assign) UIEdgeInsets contentInsets;//内边距,默认为(0,0,0,0)
@property(nonatomic,assign) CGFloat interitemSpacing;//元素间的间隔,默认为0
@property(nonatomic,assign) CGFloat lineSpacing;//行间的间隔,默认为0

- (instancetype)initWithItems:(NSArray<id<HVUILayoutConstraintItemProtocol>> *)items bounds:(CGRect)bounds numberOfRows:(NSUInteger)numberOfRows numberOfCols:(NSUInteger)numberOfCols;
@end
/**
 *
 items:A~G
 3x3:numberOfRows=3,numberOfCols=3
 ___________
|_A_|_B_|_C_|
|_D_|_E_|_F_|
|_G_|___|___|
 
 items:A~G
 3x4:numberOfRows=3,numberOfCols=4
 _______________
|_A_|_B_|_C_|_D_|
|_E_|_F_|_G_|___|
|___|___|___|___|
 */
