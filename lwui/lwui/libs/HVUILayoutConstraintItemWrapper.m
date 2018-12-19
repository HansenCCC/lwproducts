//
//  HVUILayoutConstraintItemWrapper.m
//  hvui
//
//  Created by moon on 2017/6/5.
//  Copyright © 2017年 heimavista. All rights reserved.
//

#import "HVUILayoutConstraintItemWrapper.h"
#import <objc/runtime.h>

@implementation HVUILayoutConstraintItemWrapper

+ (HVUILayoutConstraintItemWrapper *)wrapItem:(id<HVUILayoutConstraintItemProtocol>)originItem{
	HVUILayoutConstraintItemWrapper *wrapper = [[HVUILayoutConstraintItemWrapper alloc] init];
	wrapper.originItem = originItem;
	return wrapper;
}
+ (__kindof HVUILayoutConstraintItemWrapper *)wrapItem:(id<HVUILayoutConstraintItemProtocol>)originItem fixedSize:(CGSize)fixedSize{
	HVUILayoutConstraintItemWrapper *wrapper = [HVUILayoutConstraintItemWrapper wrapItem:originItem];
	wrapper.fixedSize = fixedSize;
	return wrapper;
}
+ (__kindof HVUILayoutConstraintItemWrapper *)wrapItem:(id<HVUILayoutConstraintItemProtocol>)originItem sizeThatFitsBlock:(HVUILayoutConstraintItemWrapperBlock)sizeThatFitsBlock{
	HVUILayoutConstraintItemWrapper *wrapper = [HVUILayoutConstraintItemWrapper wrapItem:originItem];
	wrapper.sizeThatFitsBlock = sizeThatFitsBlock;
	return wrapper;
}
#pragma mark - delegate:HVUILayoutConstraintItemProtocol
- (void)setLayoutFrame:(CGRect)frame{
	CGRect f = UIEdgeInsetsInsetRect(frame, self.margin);
	[self.originItem setLayoutFrame:f];
}
- (CGRect)layoutFrame{
	CGRect f = self.originItem.layoutFrame;
	UIEdgeInsets margin = self.margin;
	f.origin.x -= margin.left;
	f.origin.y -= margin.top;
	f.size.width += margin.left+margin.right;
	f.size.height += margin.top+margin.bottom;
	return f;
}
- (CGSize)sizeOfLayout{
	UIEdgeInsets margin = self.margin;
	CGSize size = [self.originItem sizeOfLayout];
	size.width += margin.left+margin.right;
	size.height += margin.top+margin.bottom;
	return size;
}
- (BOOL)hidden{
	return [self.originItem hidden];
}
//#pragma mark - forwardInvocation
//根据self.originItem来判断是否有实现sizeThatFits相关方法
//- (BOOL)respondsToSelector:(SEL)aSelector{
//	BOOL result = [super respondsToSelector:aSelector];
//	if(!result){
//		if(aSelector==@selector(sizeThatFits:)){
//			if(self.sizeThatFitsBlock!=nil||[self.originItem respondsToSelector:@selector(sizeThatFits:)]){
//				result = YES;
//			}
//		}else if(aSelector==@selector(sizeThatFits:resizeItems:)){
//			if(self.sizeThatFitsResizeItemsBlock!=nil||[self.originItem respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
//				result = YES;
//			}
//		}else if(aSelector==@selector(layoutItemsWithResizeItems:)){
//			if([self.originItem respondsToSelector:@selector(layoutItemsWithResizeItems:)]){
//				result = YES;
//			}
//		}
//	}
//	return result;
//}
//- (void)forwardInvocation:(NSInvocation *)invocation{
//	SEL aSelector = [invocation selector];
//	if(aSelector==@selector(sizeThatFits:)){
//		if(self.sizeThatFitsBlock!=nil||[self.originItem respondsToSelector:@selector(sizeThatFits:)]){
//			invocation.selector = @selector(__sizeThatFits:);
//			[invocation invokeWithTarget:invocation.target];
//		}
//	}else if(aSelector==@selector(sizeThatFits:resizeItems:)){
//		if(self.sizeThatFitsBlock!=nil||[self.originItem respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
//			invocation.selector = @selector(__sizeThatFits:resizeItems:);
//			[invocation invokeWithTarget:invocation.target];
//		}
//	}else if(aSelector==@selector(layoutItemsWithResizeItems:)){
//		if([self.originItem respondsToSelector:@selector(layoutItemsWithResizeItems:)]){
//			invocation.selector = @selector(__layoutItemsWithResizeItems:);
//			[invocation invokeWithTarget:invocation.target];
//		}
//	}else{
//		[super forwardInvocation:invocation];
//	}
//}
- (CGSize)sizeThatFits:(CGSize)size{
	CGSize sizeFits = size;
	if(self.sizeThatFitsBlock){
		sizeFits = self.sizeThatFitsBlock(self,size,NO);
	}else{
		if([self.originItem respondsToSelector:@selector(sizeThatFits:)]){
			CGSize s = [self.originItem sizeThatFits:size];
			CGSize fixedSize = self.fixedSize;
			if(fixedSize.width>0){
				s.width = fixedSize.width;
			}
			if(fixedSize.height>0){
				s.height = fixedSize.height;
			}
			UIEdgeInsets margin = self.margin;
			CGSize paddingSize = self.paddingSize;
			sizeFits.width = s.width+margin.left+margin.right+paddingSize.width;
			sizeFits.height = s.height+margin.top+margin.bottom+paddingSize.height;
		}
	}
	return sizeFits;
}
- (CGSize)sizeThatFits:(CGSize)size resizeItems:(BOOL)resizeItems{
	CGSize sizeFits = size;
	if(self.sizeThatFitsBlock){
		sizeFits = self.sizeThatFitsBlock(self,size,resizeItems);
	}else{
		if([self.originItem respondsToSelector:@selector(sizeThatFits:resizeItems:)]){
			CGSize s = [self.originItem sizeThatFits:size resizeItems:resizeItems];
			CGSize fixedSize = self.fixedSize;
			if(fixedSize.width>0){
				s.width = fixedSize.width;
			}
			if(fixedSize.height>0){
				s.height = fixedSize.height;
			}
			UIEdgeInsets margin = self.margin;
			CGSize paddingSize = self.paddingSize;
			sizeFits.width = s.width+margin.left+margin.right+paddingSize.width;
			sizeFits.height = s.height+margin.top+margin.bottom+paddingSize.height;
		}else{
			sizeFits = [self sizeThatFits:size];
		}
	}
	return sizeFits;
}
- (void)layoutItemsWithResizeItems:(BOOL)resizeItems{
	if([self.originItem respondsToSelector:@selector(layoutItemsWithResizeItems:)]){
		[self.originItem layoutItemsWithResizeItems:resizeItems];
	}
}
@end
