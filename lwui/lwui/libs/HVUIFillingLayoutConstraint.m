//
//  HVUIFillingLayoutConstraint.m
//  hvui
//
//  Created by moon on 16/6/23.
//  Copyright © 2016年 heimavista. All rights reserved.
//

#import "HVUIFillingLayoutConstraint.h"
#import "HVUIFlowLayoutConstraint.h"
@interface HVUIFillingLayoutConstraint (){
	BOOL __needConfigSubFlowLayouts;
}
@property(nonatomic,strong) HVUIFlowLayoutConstraint *beforeItemsFlowlayout;
@property(nonatomic,strong) HVUIFlowLayoutConstraint *afterItemsFlowlayout;
@end

@implementation HVUIFillingLayoutConstraint
- (id)init{
	if (self=[super init]) {
		self.beforeItemsFlowlayout = [[HVUIFlowLayoutConstraint alloc] init];
		self.afterItemsFlowlayout = [[HVUIFlowLayoutConstraint alloc] init];
		_layoutDirection = HVUILayoutConstraintDirectionHorizontal;
		_layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
		__needConfigSubFlowLayouts = YES;
	}
	return self;
}
- (void)setFillingItem:(id<HVUILayoutConstraintItemProtocol>)fillingItem{
	_fillingItem = fillingItem;
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
	NSInteger fillingItemIndex = [self.items indexOfObject:self.fillingItem];
	self.beforeItemsFlowlayout.items = fillingItemIndex>0?[self.items subarrayWithRange:NSMakeRange(0, fillingItemIndex)]:nil;
	self.afterItemsFlowlayout.items = fillingItemIndex<self.items.count-1?[self.items subarrayWithRange:NSMakeRange(fillingItemIndex+1, self.items.count-fillingItemIndex-1)]:nil;
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
	CGRect f1 = bounds;
	CGRect f2 = bounds;
	CGRect f_filling = bounds;
	
	switch (self.layoutDirection) {
		case HVUILayoutConstraintDirectionHorizontal:
		{
			CGFloat maxHeight = 0;
			//计算前半部分
			if(self.fillingItem){
				f1.size.width -= space;
			}
			CGSize f1_size_fit = [self.beforeItemsFlowlayout sizeThatFits:f1.size resizeItems:resizeItems];
			maxHeight = MAX(maxHeight,f1_size_fit.height);
			//计算后半部分
			if(self.fillingItem){
				f2.size.width -= space;
			}
			if(f1_size_fit.width>0){
				f2.size.width -= f1_size_fit.width+space;
				f_filling.size.width -= f1_size_fit.width+space;
			}
			CGSize f2_size_fit = [self.afterItemsFlowlayout sizeThatFits:f2.size resizeItems:resizeItems];
			maxHeight = MAX(maxHeight,f2_size_fit.height);
			//布局填充元素
			if(f2_size_fit.width>0){
				f_filling.size.width -= f2_size_fit.width-space;
			}
			CGSize f_filling_size_fit = f_filling.size;
			if([self.fillingItem respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
				f_filling_size_fit = [self.fillingItem sizeThatFits:f_filling.size resizeItems:resizeItems];
			}else{
				f_filling_size_fit = [self.fillingItem sizeThatFits:f_filling.size];
			}
			maxHeight = MAX(maxHeight,f_filling_size_fit.height);
			if(maxHeight){
				sizeFits.height = maxHeight+insets.top+insets.bottom;
			}
			sizeFits.width = size.width;
		}
			break;
		case HVUILayoutConstraintDirectionVertical://垂直布局
		{
			CGFloat maxWidth = 0;
			//计算前半部分
			if(self.fillingItem){
				f1.size.height -= space;
			}
			CGSize f1_size_fit = [self.beforeItemsFlowlayout sizeThatFits:f1.size resizeItems:resizeItems];
			maxWidth = MAX(maxWidth,f1_size_fit.width);
			//计算后半部分
			if(self.fillingItem){
				f2.size.height -= space;
			}
			if(f1_size_fit.height>0){
				f2.size.height -= f1_size_fit.height+space;
				f_filling.size.height -= f1_size_fit.height+space;
			}
			CGSize f2_size_fit = [self.afterItemsFlowlayout sizeThatFits:f2.size resizeItems:resizeItems];
			maxWidth = MAX(maxWidth,f2_size_fit.width);
			//布局填充元素
			if(f2_size_fit.width>0){
				f_filling.size.height -= f2_size_fit.height-space;
			}
			CGSize f_filling_size_fit = f_filling.size;
			if([self.fillingItem respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
				f_filling_size_fit = [self.fillingItem sizeThatFits:f_filling.size resizeItems:resizeItems];
			}else{
				f_filling_size_fit = [self.fillingItem sizeThatFits:f_filling.size];
			}
			maxWidth = MAX(maxWidth,f_filling_size_fit.width);
			if(maxWidth){
				sizeFits.width = maxWidth+insets.left+insets.left;
			}
			sizeFits.height = size.height;
		}
			break;
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
	CGRect f1 = bounds;
	CGRect f2 = bounds;
	CGRect f_filling = bounds;
	switch (self.layoutDirection) {
		case HVUILayoutConstraintDirectionHorizontal:
		{
			self.beforeItemsFlowlayout.bounds = f1;
			[self.beforeItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
			//
			id<HVUILayoutConstraintItemProtocol> item1 = [self.beforeItemsFlowlayout.visiableItems lastObject];
			CGRect item1Frame = [item1 layoutFrame];
			if(item1&&CGRectGetMaxX(item1Frame)!=f1.origin.x){
				f_filling.origin.x = CGRectGetMaxX(item1Frame)+space;
				f_filling.size.width = CGRectGetMaxX(bounds)-f_filling.origin.x;
				f2.origin.x = f_filling.origin.x;
				f2.size.width = f_filling.size.width;
			}
			self.afterItemsFlowlayout.bounds = f2;
			[self.afterItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
			id<HVUILayoutConstraintItemProtocol> item2 = [self.afterItemsFlowlayout.visiableItems firstObject];
			CGRect item2Frame = [item2 layoutFrame];
			if(item2&&item2Frame.origin.x!=CGRectGetMaxX(f2)){
				f_filling.size.width = item2Frame.origin.x-space-f_filling.origin.x;
			}
			if(resizeItems){
				if([self.fillingItem respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
					CGSize f_filling_size = [self.fillingItem sizeThatFits:f_filling.size resizeItems:resizeItems];
					f_filling.size.height = f_filling_size.height;
				}else if([self.fillingItem respondsToSelector:@selector(sizeThatFits:)]){
					CGSize f_filling_size = [self.fillingItem sizeThatFits:f_filling.size];
					f_filling.size.height = f_filling_size.height;
				}
			}
			switch (self.layoutVerticalAlignment) {
				case HVUILayoutConstraintVerticalAlignmentCenter:
					f_filling.origin.y = bounds.origin.y+(bounds.size.height-f_filling.size.height)/2;
					break;
				case HVUILayoutConstraintVerticalAlignmentTop:
					f_filling.origin.y = bounds.origin.y;
					break;
				case HVUILayoutConstraintVerticalAlignmentBottom:
					f_filling.origin.y = CGRectGetMaxY(bounds)-f_filling.size.height;
					break;
				default:
					break;
			}
			if([self.fillingItem respondsToSelector:@selector(layoutItemsWithResizeItems:)]){
				[self.fillingItem setLayoutFrame:f_filling];
				[self.fillingItem layoutItemsWithResizeItems:resizeItems];
			}else{
				[self.fillingItem setLayoutFrame:f_filling];
			}
		}
			break;
		case HVUILayoutConstraintDirectionVertical:
		{
			self.beforeItemsFlowlayout.bounds = f1;
			[self.beforeItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
			//
			id<HVUILayoutConstraintItemProtocol> item1 = [self.beforeItemsFlowlayout.visiableItems lastObject];
			CGRect item1Frame = [item1 layoutFrame];
			if(item1&&CGRectGetMaxY(item1Frame)!=f1.origin.y){
				f_filling.origin.y = CGRectGetMaxY(item1Frame)+space;
				f_filling.size.height = CGRectGetMaxY(bounds)-f_filling.origin.y;
				f2.origin.y = f_filling.origin.y;
				f2.size.height = f_filling.size.height;
			}
			self.afterItemsFlowlayout.bounds = f2;
			[self.afterItemsFlowlayout layoutItemsWithResizeItems:resizeItems];
			id<HVUILayoutConstraintItemProtocol> item2 = [self.afterItemsFlowlayout.visiableItems firstObject];
			CGRect item2Frame = [item2 layoutFrame];
			if(item2&&item2Frame.origin.y!=CGRectGetMaxY(f2)){
				f_filling.size.height = item2Frame.origin.y-space-f_filling.origin.y;
			}
			if(resizeItems){
				if([self.fillingItem respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
					CGSize f_filling_size = [self.fillingItem sizeThatFits:f_filling.size resizeItems:resizeItems];
					f_filling.size.width = f_filling_size.width;
				}else if([self.fillingItem respondsToSelector:@selector(sizeThatFits:)]){
					CGSize f_filling_size = [self.fillingItem sizeThatFits:f_filling.size];
					f_filling.size.width = f_filling_size.width;
				}
			}
			switch (self.layoutHorizontalAlignment) {
				case HVUILayoutConstraintHorizontalAlignmentCenter:
					f_filling.origin.x = bounds.origin.x+(bounds.size.width-f_filling.size.width)/2;
					break;
				case HVUILayoutConstraintHorizontalAlignmentLeft:
					f_filling.origin.x = bounds.origin.x;
					break;
				case HVUILayoutConstraintHorizontalAlignmentRight:
					f_filling.origin.x = CGRectGetMaxX(bounds)-f_filling.size.width;
					break;
				default:
					break;
			}
			if([self.fillingItem respondsToSelector:@selector(layoutItemsWithResizeItems:)]){
				[self.fillingItem setLayoutFrame:f_filling];
				[self.fillingItem layoutItemsWithResizeItems:resizeItems];
			}else{
				[self.fillingItem setLayoutFrame:f_filling];
			}
		}
			break;
	}
}
@end

@implementation HVUIFillingLayoutConstraint (InitMethod)
- (id)initWithItems:(NSArray<id<HVUILayoutConstraintItemProtocol>> *)items fillingItem:(id<HVUILayoutConstraintItemProtocol>)fillingItem constraintParam:(HVUIFillingLayoutConstraintParam)param contentInsets:(UIEdgeInsets)contentInsets interitemSpacing:(CGFloat)interitemSpacing{
	if(self=[self init]){
		self.items = items;
		self.fillingItem = fillingItem;
		[self configWithConstraintParam:param];
		self.contentInsets = contentInsets;
		self.interitemSpacing = interitemSpacing;
	}
	return self;
}
- (void)configWithConstraintParam:(HVUIFillingLayoutConstraintParam)param{
	switch (param) {
		case HVUIFillingLayoutConstraint_H_C:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentCenter;
			break;
		case HVUIFillingLayoutConstraint_H_T:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentTop;
			break;
		case HVUIFillingLayoutConstraint_H_B:
			self.layoutDirection = HVUILayoutConstraintDirectionHorizontal;
			self.layoutVerticalAlignment = HVUILayoutConstraintVerticalAlignmentBottom;
			break;
		case HVUIFillingLayoutConstraint_V_C:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentCenter;
			break;
		case HVUIFillingLayoutConstraint_V_L:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentLeft;
			break;
		case HVUIFillingLayoutConstraint_V_R:
			self.layoutDirection = HVUILayoutConstraintDirectionVertical;
			self.layoutHorizontalAlignment = HVUILayoutConstraintHorizontalAlignmentRight;
			break;
	}
}
@end