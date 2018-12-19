//
//  HVUISegmentFlowLayoutConstraint.h
//  hvui
//	将bounds切分成两块,然后两块靠边各自进行流布局
//  Created by moon on 16/2/27.
//  Copyright © 2016年 heimavista. All rights reserved.
//

#import "HVUILayoutConstraint.h"

@interface HVUISegmentFlowLayoutConstraint : HVUILayoutConstraint
@property(nonatomic,assign) HVUILayoutConstraintDirection layoutDirection;//布局方向.默认为HVUILayoutConstraintDirectionVertical
@property(nonatomic,assign) HVUILayoutConstraintVerticalAlignment layoutVerticalAlignment;//所有元素作为一个整体,在垂直方向上的位置,以及每一个元素在整体内的垂直方向上的对齐方式.默认为HVUILayoutConstraintVerticalAlignmentCenter

@property(nonatomic,assign) HVUILayoutConstraintHorizontalAlignment layoutHorizontalAlignment;//所有元素作为一个整体,在水平方向上的位置,以及每一个元素在整体内的水平方向上的对方方式.默认为HVUILayoutConstraintHorizontalAlignmentCenter
@property(nonatomic,assign) UIEdgeInsets contentInsets;//内边距,默认为(0,0,0,0)
@property(nonatomic,assign) CGFloat interitemSpacing;//元素间的间隔,默认为0

@property(nonatomic,assign) NSInteger boundaryItemIndex;//临界点,用于将self.items区分成两块,第一块为[0,boundaryItemIndex],第二块为(boundaryItemIndex,self.items.count)
- (void)setBoundaryItemIndexWithItem:(id<HVUILayoutConstraintItemProtocol>)item;
@property(nonatomic,assign) BOOL isLayoutPriorityFirstItems;//是否优先布局前半部分.如果是,对前半部分sizeToFit,然后bounds扣掉前半部分区域,剩下区域给后半部分布局.默认为NO
@property(nonatomic,assign) CGFloat layoutPriorityItemsMaxBoundsPercent;//优先布局的一方,最多占掉bounds的宽/长的百分比,默认为0.75
@property(nonatomic,assign) BOOL fixSizeToFitsBounds;//在计算sizeThatFits时,根据布局方向,自动固定对应边的尺寸为传入的 size 的边,(如水平布局时,sizeThatFits.width=size.width),默认为 NO,即不固定

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
	HVUISegmentFlowLayoutConstraint_H_C,
	HVUISegmentFlowLayoutConstraint_H_T,
	HVUISegmentFlowLayoutConstraint_H_B,
	HVUISegmentFlowLayoutConstraint_V_C,
	HVUISegmentFlowLayoutConstraint_V_L,
	HVUISegmentFlowLayoutConstraint_V_R,
} HVUISegmentFlowLayoutConstraintParam;
@interface HVUISegmentFlowLayoutConstraint (InitMethod)
- (id)initWithItems:(NSArray<id<HVUILayoutConstraintItemProtocol>> *)items constraintParam:(HVUISegmentFlowLayoutConstraintParam)param contentInsets:(UIEdgeInsets)contentInsets interitemSpacing:(CGFloat)interitemSpacing;
- (void)configWithConstraintParam:(HVUISegmentFlowLayoutConstraintParam)param;
@end
/**
 *
 以下为layoutDirection,layoutVerticalAlignment,layoutHorizontalAlignment的6种组合:
 
 HVUISegmentFlowLayoutConstraint_H_C
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
 :
  _________________
 |                 |
 |  B              |
 |A B             C|
 |  B              |
 |_________________|
 
 HVUISegmentFlowLayoutConstraint_H_T
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
 :
  _________________
 |A B             C|
 |  B             C|
 |  B              |
 |                 |
 |_________________|
 
 HVUISegmentFlowLayoutConstraint_H_B
 layoutDirection = HVUILayoutConstraintDirectionHorizontal;
 layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
 :
  _________________
 |                 |
 |                 |
 |  B              |
 |  B             C|
 |A_B_____________C|
 
 HVUISegmentFlowLayoutConstraint_V_C
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
 :
  _____
 |  A  |
 | BBB |
 |     |
 |     |
 |__C__|
 
 HVUISegmentFlowLayoutConstraint_V_L
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
 :
  _____
 |A    |
 |BBB  |
 |     |
 |     |
 |CC___|
 
 HVUISegmentFlowLayoutConstraint_V_R
 layoutDirection = HVUILayoutConstraintDirectionVertical;
 layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
 :
  _____
 |    A|
 |  BBB|
 |     |
 |     |
 |___CC|
  */
