//
//  HVUISegmentFlowLayoutConstraint.m
//  hvui
//
//  Created by moon on 16/2/27.
//  Copyright © 2016年 heimavista. All rights reserved.
//

#import "HVUISegmentFlowLayoutConstraint.h"
#import "HVUIFlowLayoutConstraint.h"
@interface HVUISegmentFlowLayoutConstraint (){
	BOOL __needConfigSubFlowLayouts;
}
@property(nonatomic,strong) HVUIFlowLayoutConstraint *beforeItemsFlowlayout;
@property(nonatomic,strong) HVUIFlowLayoutConstraint *afterItemsFlowlayout;
@end

@implementation HVUISegmentFlowLayoutConstraint
- (id)init{
	if (self=[super init]) {
		self.beforeItemsFlowlayout = [[HVUIFlowLayoutConstraint alloc] init];
		self.afterItemsFlowlayout = [[HVUIFlowLayoutConstraint alloc] init];
		_layoutDirection = HVUILayoutConstraintDirectionHorizontal;
		_layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
		_isLayoutPriorityFirstItems = NO;
		_layoutPriorityItemsMaxBoundsPercent= 0.75;
		__needConfigSubFlowLayouts = YES;
	}
	return self;
}
- (void)setBoundaryItemIndexWithItem:(id<HVUILayoutConstraintItemProtocol>)item{
	NSInteger index = [self.items indexOfObject:item];
	if(index!=NSNotFound){
		self.boundaryItemIndex = index;
	}else{
		//出错了
	}
}
- (void)setBoundaryItemIndex:(NSInteger)boundaryItemIndex{
	_boundaryItemIndex = boundaryItemIndex;
	__needConfigSubFlowLayouts = YES;
}
- (void)setLayoutDirection:(HVUILayoutConstraintDirection)layoutDirection{
	_layoutDirection = layoutDirection;
	__needConfigSubFlowLayouts = YES;
}
- (void)setLayoutHorizontalAlignment:(HVUILayoutConstraintHorizontalAlignment)layoutHorizontalAlignment{
	_layoutHorizontalAlignment = layoutHorizontalAlignment;
	__needConfigSubFlowLayouts = YES;
}
- (void)setLayoutVerticalAlignment:(HVUILayoutConstraintVerticalAlignment)layoutVerticalAlignment{
	_layoutVerticalAlignment = layoutVerticalAlignment;
	__needConfigSubFlowLayouts = YES;
}
- (void)setItems:(NSArray *)items{
	[super setItems:items];
	__needConfigSubFlowLayouts = YES;
}
- (void)setInteritemSpacing:(CGFloat)interitemSpacing{
	_interitemSpacing = interitemSpacing;
	__needConfigSubFlowLayouts = YES;
}
- (void)setContentInsets:(UIEdgeInsets)contentInsets{
	_contentInsets = contentInsets;
	__needConfigSubFlowLayouts = YES;
}
- (void)__configSubFlowLayouts{
	__needConfigSubFlowLayouts = NO;
	self.beforeItemsFlowlayout.items = [self.items subarrayWithRange:NSMakeRange(0, self.boundaryItemIndex+1)];
	self.afterItemsFlowlayout.items = [self.items subarrayWithRange:NSMakeRange(self.boundaryItemIndex+1, self.items.count-self.boundaryItemIndex-1)];
	//
	self.beforeItemsFlowlayout.interitemSpacing = self.interitemSpacing;
	self.afterItemsFlowlayout.interitemSpacing = self.interitemSpacing;
	//
	self.beforeItemsFlowlayout.layoutDirection = self.layoutDirection;
	self.afterItemsFlowlayout.layoutDirection = self.layoutDirection;
	//
	if(self.layoutDirection==HVUILayoutConstraintDirectionHorizontal){//水平方向布局,A B C
		self.beforeItemsFlowlayout.layoutVerticalAlignment = self.layoutVerticalAlignment;
		self.afterItemsFlowlayout.layoutVerticalAlignment = self.layoutVerticalAlignment;
		self.beforeItemsFlowlayout.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
		self.afterItemsFlowlayout.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
	}else{//垂直方向布局
		/**
		 A
		 B
		 C
		 */
		self.beforeItemsFlowlayout.layoutHorizontalAlignment = self.layoutHorizontalAlignment;
		self.afterItemsFlowlayout.layoutHorizontalAlignment = self.layoutHorizontalAlignment;
		self.beforeItemsFlowlayout.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
		self.afterItemsFlowlayout.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
	}
}
- (CGSize)sizeThatFits:(CGSize)size resizeItems:(BOOL)resizeItems{
	if(__needConfigSubFlowLayouts){
		[self __configSubFlowLayouts];
	}
	CGSize sizeFits = CGSizeZero;
	UIEdgeInsets insets = self.contentInsets;
	CGRect bounds = CGRectZero;
	bounds.size = size;
	bounds = UIEdgeInsetsInsetRect(bounds, insets);
	CGFloat space = self.interitemSpacing;
	if(self.beforeItemsFlowlayout.visiableItems.count==0||self.afterItemsFlowlayout.visiableItems.count==0){
		space = 0;
	}
	CGRect f1 = bounds;
	CGRect f2 = bounds;
	CGSize f1_size_fit  = [self.beforeItemsFlowlayout sizeThatFits:f1.size resizeItems:resizeItems];
	CGSize f2_size_fit = [self.afterItemsFlowlayout sizeThatFits:f2.size resizeItems:resizeItems];
	switch (self.layoutDirection) {
		case HVUILayoutConstraintDirectionHorizontal:
		{
			if(self.isLayoutPriorityFirstItems){
				if(CGSizeEqualToSize(f2_size_fit, CGSizeZero)){//后半部分没有占用空间,空间全部分配给前半部分
					if(!CGSizeEqualToSize(f1_size_fit, CGSizeZero)){
						sizeFits.width = insets.left+insets.right+f1_size_fit.width;
						sizeFits.height = insets.top+insets.bottom+f1_size_fit.height;
					}
				}else{
					f1.size.width =  self.layoutPriorityItemsMaxBoundsPercent*(bounds.size.width-space);
					CGSize f1_size = f1_size_fit.width<=f1.size.width&&f1_size_fit.height<=f1.size.height?f1_size_fit:[self.beforeItemsFlowlayout sizeThatFits:f1.size resizeItems:resizeItems];
					f1.size.width = MIN(f1_size.width,f1.size.width);
					f1.size.height = MIN(f1_size.height,f1.size.height);
					//
					f2.size.width = bounds.size.width-f1.size.width-space;
					CGSize f2_size = f2_size_fit.width<=f2.size.width&&f2_size_fit.height<=f2.size.height?f2_size_fit:[self.afterItemsFlowlayout sizeThatFits:f2.size resizeItems:resizeItems];
					f2.size.width = MIN(f2_size.width,f2.size.width);
					f2.size.height = MIN(f2_size.height,f2.size.height);
					CGFloat maxHeight = MAX(f1.size.height,f2.size.height);
					if(maxHeight){
						sizeFits.height = insets.top+insets.bottom+maxHeight;
					}
					if(f1.size.width+f2.size.width>0){
						sizeFits.width = insets.left+insets.right+f1.size.width+space+f2.size.width;
					}
				}
			}else{
				if(CGSizeEqualToSize(f1_size_fit, CGSizeZero)){//前半部分没有占用空间,空间全部分配给后半部分
					if(!CGSizeEqualToSize(f2_size_fit, CGSizeZero)){
						sizeFits.width = insets.left+insets.right+f2_size_fit.width;
						sizeFits.height = insets.top+insets.bottom+f2_size_fit.height;
					}
				}else{
					f2.size.width = self.layoutPriorityItemsMaxBoundsPercent*(bounds.size.width-space);
					CGSize f2_size = f2_size_fit.width<=f2.size.width&&f2_size_fit.height<=f2.size.height?f2_size_fit:[self.afterItemsFlowlayout sizeThatFits:f2.size resizeItems:resizeItems];
					f2.size.width = MIN(f2_size.width,f2.size.width);
					f2.size.height = MIN(f2_size.height,f2.size.height);
					//
					f1.size.width = bounds.size.width-f2.size.width-space;
					CGSize f1_size = f1_size_fit.width<=f1.size.width&&f1_size_fit.height<=f1.size.height?f1_size_fit:[self.beforeItemsFlowlayout sizeThatFits:f1.size resizeItems:resizeItems];
					f1.size.width = MIN(f1_size.width,f1.size.width);
					f1.size.height = MIN(f1_size.height,f1.size.height);
					CGFloat maxHeight = MAX(f1.size.height,f2.size.height);
					if(maxHeight){
						sizeFits.height = insets.top+insets.bottom+maxHeight;
					}
					if(f1.size.width+f2.size.width>0){
						sizeFits.width = insets.left+insets.right+f1.size.width+space+f2.size.width;
					}
				}
			}
		}
			break;
		case HVUILayoutConstraintDirectionVertical:
		{
			if(self.isLayoutPriorityFirstItems){
				if(CGSizeEqualToSize(f2_size_fit, CGSizeZero)){//后半部分没有占用空间,空间全部分配给前半部分
					if(!CGSizeEqualToSize(f1_size_fit, CGSizeZero)){
						sizeFits.width = insets.left+insets.right+f1_size_fit.width;
						sizeFits.height = insets.top+insets.bottom+f1_size_fit.height;
					}
				}else{
					f1.size.height = self.layoutPriorityItemsMaxBoundsPercent*(bounds.size.height-space);
					CGSize f1_size = f1_size_fit.width<=f1.size.width&&f1_size_fit.height<=f1.size.height?f1_size_fit:[self.beforeItemsFlowlayout sizeThatFits:f1.size resizeItems:resizeItems];
					f1.size.height = MIN(f1_size.height,f1.size.height);
					f1.size.width = MIN(f1_size.width,f1.size.width);
					//
					f2.size.height = bounds.size.height-f2.size.height-space;
					CGSize f2_size = f2_size_fit.width<=f2.size.width&&f2_size_fit.height<=f2.size.height?f2_size_fit:[self.afterItemsFlowlayout sizeThatFits:f2.size resizeItems:resizeItems];
					f2.size.height = MIN(f2.size.height,f2_size.height);
					f2.size.width = MIN(f2.size.width,f2_size.width);
					if(f1.size.height+f2.size.height>0){
						sizeFits.height = insets.top+insets.bottom+f1.size.height+f2.size.height+space;
					}
					CGFloat maxWidth = MAX(f1.size.width,f2.size.width);
					if(maxWidth){
						sizeFits.width = insets.left+insets.right+maxWidth;
					}
				}
			}else{
				if(CGSizeEqualToSize(f1_size_fit, CGSizeZero)){//前半部分没有占用空间,空间全部分配给后半部分
					if(!CGSizeEqualToSize(f2_size_fit, CGSizeZero)){
						sizeFits.width = insets.left+insets.right+f2_size_fit.width;
						sizeFits.height = insets.top+insets.bottom+f2_size_fit.height;
					}
				}else{
					f2.size.height = self.layoutPriorityItemsMaxBoundsPercent*(bounds.size.width-space);
					CGSize f2_size = f2_size_fit.width<=f2.size.width&&f2_size_fit.height<=f2.size.height?f2_size_fit:[self.afterItemsFlowlayout sizeThatFits:f2.size resizeItems:resizeItems];
					f2.size.height = MIN(f2_size.height,f2.size.height);
					f2.size.width = MIN(f2_size.width,f2.size.width);
					//
					f1.size.height = bounds.size.height-f2.size.height-space;
					CGSize f1_size = f1_size_fit.width<=f1.size.width&&f1_size_fit.height<=f1.size.height?f1_size_fit:[self.beforeItemsFlowlayout sizeThatFits:f1.size resizeItems:resizeItems];
					f1.size.height = MIN(f1.size.height,f1_size.height);
					f1.size.width = MIN(f1.size.width,f1_size.width);
					if(f1.size.height+f2.size.height>0){
						sizeFits.height = insets.top+insets.bottom+f1.size.height+f2.size.height+space;
					}
					CGFloat maxWidth = MAX(f1.size.width,f2.size.width);
					if(maxWidth){
						sizeFits.width = insets.left+insets.right+maxWidth;
					}
				}
			}
		}
			break;
	}
	if(self.fixSizeToFitsBounds){
		switch (self.layoutDirection) {
			case HVUILayoutConstraintDirectionHorizontal:
				sizeFits.width = size.width;
				break;
			case HVUILayoutConstraintDirectionVertical:
				sizeFits.height = size.height;
				break;
			default:
				break;
		}
	}
	return sizeFits;
}
- (void)layoutItems{
	if(__needConfigSubFlowLayouts){
		[self __configSubFlowLayouts];
	}
	[self layoutItemsWithResizeItems:NO];
}
- (void)layoutItemsWithResizeItems:(BOOL)resizeItems{
	if(__needConfigSubFlowLayouts){
		[self __configSubFlowLayouts];
	}
	UIEdgeInsets insets = self.contentInsets;
	CGRect bounds = UIEdgeInsetsInsetRect(self.bounds, insets);
	CGFloat space = self.interitemSpacing;
	if(self.beforeItemsFlowlayout.visiableItems.count==0||self.afterItemsFlowlayout.visiableItems.count==0){
		space = 0;
	}
	CGRect f1 = bounds;
	CGRect f2 = bounds;
	switch (self.layoutDirection) {
		case HVUILayoutConstraintDirectionHorizontal:
		{
			if(self.isLayoutPriorityFirstItems){
				BOOL isAfterItemsEmpty = [self.afterItemsFlowlayout isEmptyBounds:f2 withResizeItems:resizeItems];
				if(isAfterItemsEmpty){
					self.beforeItemsFlowlayout.bounds = f1;
					[self.beforeItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
				}else{
					f1.size.width = self.layoutPriorityItemsMaxBoundsPercent*(bounds.size.width-space);
					CGSize f1_size = [self.beforeItemsFlowlayout sizeThatFits:f1.size resizeItems:resizeItems];
					f1.size.width = MIN(f1_size.width,f1.size.width);
					self.beforeItemsFlowlayout.bounds = f1;
					[self.beforeItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
					//
					f2.origin.x = CGRectGetMaxX(f1)+space;
					f2.size.width = CGRectGetMaxX(bounds)-f2.origin.x;
					self.afterItemsFlowlayout.bounds = f2;
					[self.afterItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
				}
			}else{
				BOOL isBeforeItemsEmpty = [self.beforeItemsFlowlayout isEmptyBounds:f1 withResizeItems:resizeItems];
				if(isBeforeItemsEmpty){
					self.afterItemsFlowlayout.bounds = f2;
					[self.afterItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
				}else{
					f2.size.width = self.layoutPriorityItemsMaxBoundsPercent*(bounds.size.width-space);
					CGSize f2_size = [self.afterItemsFlowlayout sizeThatFits:f2.size resizeItems:resizeItems];
					f2.size.width = MIN(f2_size.width,f2.size.width);
					f2.origin.x = CGRectGetMaxX(bounds)-f2.size.width;
					self.afterItemsFlowlayout.bounds = f2;
					[self.afterItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
					//
					f1.size.width = f2.origin.x-space-f1.origin.x;
					self.beforeItemsFlowlayout.bounds = f1;
					[self.beforeItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
				}
			}
		}
			break;
		case HVUILayoutConstraintDirectionVertical:
		{
			if(self.isLayoutPriorityFirstItems){
				BOOL isAfterItemsEmpty = [self.afterItemsFlowlayout isEmptyBounds:f2 withResizeItems:resizeItems];
				if(isAfterItemsEmpty){
					self.beforeItemsFlowlayout.bounds = f1;
					[self.beforeItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
				}else{
					f1.size.height = self.layoutPriorityItemsMaxBoundsPercent*(bounds.size.height-space);
					CGSize f1_size = [self.beforeItemsFlowlayout sizeThatFits:f1.size resizeItems:resizeItems];
					f1.size.height = MIN(f1_size.height,f1.size.height);
					self.beforeItemsFlowlayout.bounds = f1;
					[self.beforeItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
					//
					f2.origin.y = CGRectGetMaxY(f1)+space;
					f2.size.height = CGRectGetMaxY(bounds)-f2.origin.y;
					self.afterItemsFlowlayout.bounds = f2;
					[self.afterItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
				}
			}else{
				BOOL isBeforeItemsEmpty = [self.beforeItemsFlowlayout isEmptyBounds:f1 withResizeItems:resizeItems];
				if(isBeforeItemsEmpty){
					self.afterItemsFlowlayout.bounds = f2;
					[self.afterItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
				}else{
					f2.size.height = self.layoutPriorityItemsMaxBoundsPercent*(bounds.size.height-space);
					CGSize f2_size = [self.afterItemsFlowlayout sizeThatFits:f2.size resizeItems:resizeItems];
					f2.size.height = MIN(f2_size.height,f2.size.height);
					f2.origin.y = CGRectGetMaxY(bounds)-f2.size.height;
					self.afterItemsFlowlayout.bounds = f2;
					[self.afterItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
					//
					f1.size.height = f2.origin.y-f1.origin.y-space;
					self.beforeItemsFlowlayout.bounds = f1;
					[self.beforeItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
				}
			}
		}
			break;
	}
}
@end
@implementation HVUISegmentFlowLayoutConstraint (InitMethod)
- (id)initWithItems:(NSArray<id<HVUILayoutConstraintItemProtocol>> *)items constraintParam:(HVUISegmentFlowLayoutConstraintParam)param contentInsets:(UIEdgeInsets)contentInsets interitemSpacing:(CGFloat)interitemSpacing{
	if(self=[self init]){
		self.items = items;
		[self configWithConstraintParam:param];
		self.contentInsets = contentInsets;
		self.interitemSpacing = interitemSpacing;
	}
	return self;
}
- (void)configWithConstraintParam:(HVUISegmentFlowLayoutConstraintParam)param{
	switch (param) {
		case HVUISegmentFlowLayoutConstraint_H_C:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
			break;
		case HVUISegmentFlowLayoutConstraint_H_T:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
			break;
		case HVUISegmentFlowLayoutConstraint_H_B:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
			break;
		case HVUISegmentFlowLayoutConstraint_V_C:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
			break;
		case HVUISegmentFlowLayoutConstraint_V_L:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
			break;
		case HVUISegmentFlowLayoutConstraint_V_R:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
			break;
	}
}
@end
