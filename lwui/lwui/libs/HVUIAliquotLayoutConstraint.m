//
//  HVUIAliquotLayoutConstraint.m
//  hvui
//
//  Created by moon on 15/4/14.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUIAliquotLayoutConstraint.h"

@implementation HVUIAliquotLayoutConstraint
+ (void)aliquotLayoutWithItems:(NSArray *)items bounds:(CGRect)bounds layoutDirection:(HVUILayoutConstraintDirection)layoutDirection{
	HVUIAliquotLayoutConstraint *lc = [[HVUIAliquotLayoutConstraint alloc] initWithItems:items bounds:bounds];
	lc.layoutDirection = layoutDirection;
	[lc layoutItems];
}
- (CGSize)sizeThatFits:(CGSize)size{
	CGSize sizeFits = size;
	NSInteger count = self.visiableItems.count;
	if(count==0)return CGSizeZero;
	return sizeFits;
}
- (void)layoutItemsWithHidden:(BOOL)layoutHiddenItem{
	NSArray *items = layoutHiddenItem?self.items:self.visiableItems;
	NSInteger count = items.count;
	if(count==0)return;
	UIEdgeInsets contentInsets = self.contentInsets;
	CGFloat interitemSpacing = self.interitemSpacing;
	CGRect bounds = UIEdgeInsetsInsetRect(self.bounds, contentInsets);
	CGRect f = bounds;
	if(self.layoutDirection==HVUILayoutConstraintDirectionVertical){
		f.size.height = (bounds.size.height-(count-1)*interitemSpacing)/count;
	}else{
		f.size.width = (bounds.size.width-(count-1)*interitemSpacing)/count;
	}
	for (id<HVUILayoutConstraintItemProtocol> item in items) {
		[item setLayoutFrame:f];
		if(self.layoutDirection==HVUILayoutConstraintDirectionVertical){
			f.origin.y += (f.size.height+interitemSpacing);
		}else{
			f.origin.x += (f.size.width+interitemSpacing);
		}
	}
}
- (void)layoutItems{
	[self layoutItemsWithHidden:NO];
}
@end
