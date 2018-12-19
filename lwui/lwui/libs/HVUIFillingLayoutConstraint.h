//
//  HVUIFillingLayoutConstraint.h
//  hvui
//	布局时,有一个填充元素,它在其他元素布局结束之后,填充剩下的空间
//  Created by moon on 16/6/23.
//  Copyright © 2016年 heimavista. All rights reserved.
//

#import "HVUILayoutConstraint.h"

@interface HVUIFillingLayoutConstraint : HVUILayoutConstraint
@property(nonatomic,assign) HVUILayoutConstraintDirection layoutDirection;//布局方向.默认为HVUILayoutConstraintDirectionVertical
@property(nonatomic,assign) HVUILayoutConstraintVerticalAlignment layoutVerticalAlignment;//所有元素作为一个整体,在垂直方向上的位置,以及每一个元素在整体内的垂直方向上的对齐方式.默认为HVUILayoutConstraintVerticalAlignmentCenter

@property(nonatomic,assign) HVUILayoutConstraintHorizontalAlignment layoutHorizontalAlignment;//所有元素作为一个整体,在水平方向上的位置,以及每一个元素在整体内的水平方向上的对方方式.默认为HVUILayoutConstraintHorizontalAlignmentCenter

@property(nonatomic,assign) UIEdgeInsets contentInsets;//内边距,默认为(0,0,0,0)
@property(nonatomic,assign) CGFloat interitemSpacing;//元素间的间隔,默认为0
@property(nonatomic,strong) id<HVUILayoutConstraintItemProtocol> fillingItem;//被填充的元素,它会在最后才进行布局,尺寸等于剩下的空白区域
/**
 *  计算最合适的尺寸
 *
 *  @param size        外层限制
 *  @param resizeItems 是否计算子元素的最合适尺寸。YES：调用子元素的sizeThatFits方法。NO：直接使用子元素的bounds.size
 *
 *  @return 最合适的尺寸
 */
- (CGSize)sizeThatFits:(CGSize)size resizeItems:(BOOL)resizeItems;

/**
 *  对子元素进行布局
 *
 *  @param resizeItems 在布局前,是否让每个子元素自动调整到合适的尺寸
 */
- (void)layoutItemsWithResizeItems:(BOOL)resizeItems;
@end

typedef enum : NSUInteger {
	HVUIFillingLayoutConstraint_H_C,
	HVUIFillingLayoutConstraint_H_T,
	HVUIFillingLayoutConstraint_H_B,
	HVUIFillingLayoutConstraint_V_C,
	HVUIFillingLayoutConstraint_V_L,
	HVUIFillingLayoutConstraint_V_R,
} HVUIFillingLayoutConstraintParam;
@interface HVUIFillingLayoutConstraint (InitMethod)
- (id)initWithItems:(NSArray<id<HVUILayoutConstraintItemProtocol>> *)items fillingItem:(id<HVUILayoutConstraintItemProtocol>)fillingItem constraintParam:(HVUIFillingLayoutConstraintParam)param contentInsets:(UIEdgeInsets)contentInsets interitemSpacing:(CGFloat)interitemSpacing;
@end

/**
 *
 以下为layoutDirection,layoutVerticalAlignment,layoutHorizontalAlignment的6种组合:
 self.fillingItem = C
 HVUIFillingLayoutConstraint_H_C
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
 :
  _________________
 |                 |
 |  B              |
 |A B CC<------->CC|
 |  B              |
 |_________________|
 
 HVUIFillingLayoutConstraint_H_T
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
 :
  _________________
 |A B CC<------->CC|
 |  B              |
 |  B              |
 |                 |
 |_________________|
 
 HVUIFillingLayoutConstraint_H_B
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
 :
  _________________
 |                 |
 |                 |
 |  B              |
 |  B              |
 |A_B_CC<------->CC|
 
 HVUIFillingLayoutConstraint_V_C
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
 :
  _____
 |  A  |
 | BBB |
 |  C  |
 |  C  |
 |__C__|
 
 HVUIFillingLayoutConstraint_V_L
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
 :
  _____
 |A    |
 |BBB  |
 |C    |
 |C    |
 |C____|
 
 HVUIFillingLayoutConstraint_V_R
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
 :
  _____
 |    A|
 |  BBB|
 |    C|
 |    C|
 |____C|
 */
