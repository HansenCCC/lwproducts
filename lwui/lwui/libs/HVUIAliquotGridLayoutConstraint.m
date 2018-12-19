//
//  HVUIAliquotGridLayoutConstraint.m
//  hvui
//
//  Created by moon on 15/4/14.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUIAliquotGridLayoutConstraint.h"

@implementation HVUIAliquotGridLayoutConstraint
- (instancetype)initWithItems:(NSArray *)items bounds:(CGRect)bounds numberOfRows:(NSUInteger)numberOfRows numberOfCols:(NSUInteger)numberOfCols{
	if(self=[super initWithItems:items bounds:bounds]){
		self.numberOfRows = numberOfRows;
		self.numberOfCols = numberOfCols;
	}
	return self;
}
- (CGSize)sizeThatFits:(CGSize)size{
	CGSize sizeFits = size;
	NSUInteger numberOfRows = self.numberOfRows;
	NSUInteger numberOfCols = self.numberOfCols;
	if(!numberOfRows||!numberOfCols)return CGSizeZero;
	NSArray *items = self.visiableItems;
	NSInteger count = items.count;
	if(count==0)return CGSizeZero;
	return sizeFits;
}
- (void)layoutItems{
	NSUInteger numberOfRows = self.numberOfRows;
	NSUInteger numberOfCols = self.numberOfCols;
	if(!numberOfRows||!numberOfCols)return;
	NSArray *items = self.visiableItems;
	NSInteger count = items.count;
	if(count==0)return;
	UIEdgeInsets contentInsets = self.contentInsets;
	CGFloat interitemSpacing = self.interitemSpacing;
	CGFloat lineSpacing = self.lineSpacing;
	CGRect bounds = UIEdgeInsetsInsetRect(self.bounds, contentInsets);
	CGRect f = bounds;
	f.size.width = (bounds.size.width-(numberOfCols-1)*interitemSpacing)/numberOfCols;
	f.size.height = (bounds.size.height-(numberOfRows-1)*lineSpacing)/numberOfRows;
	for (int i=0; i<count; i++) {
		id<HVUILayoutConstraintItemProtocol> item = [items objectAtIndex:i];
		[item setLayoutFrame:f];
		if(i%numberOfCols==numberOfCols-1){//另起一行
			f.origin.x = contentInsets.left;
			f.origin.y += (f.size.height+lineSpacing);
		}else{
			f.origin.x += (f.size.width+interitemSpacing);
		}
	}
}
@end
