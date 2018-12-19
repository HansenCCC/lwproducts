//
//  HVUICollectionViewTitleSupplementarySectionModel.m
//  hvui
//
//  Created by moon on 15/9/15.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUICollectionViewTitleSupplementarySectionModel.h"
#import "HVUICollectionViewTitleSupplementaryView.h"
@implementation HVUICollectionViewTitleSupplementarySectionModel
- (id)init{
	if (self=[super init]) {
		self.headClass = [HVUICollectionViewTitleSupplementaryView class];
		self.footClass = [HVUICollectionViewTitleSupplementaryView class];
	}
	return self;
}
- (void)setHeadClass:(Class<HVUICollectionViewSupplementaryElementProtocol>)headClass{
	_headClass = headClass;
	if(self.showHead){
		[self setSupplementaryElementViewClass:headClass forKind:UICollectionElementKindSectionHeader];
	}
}
- (void)setFootClass:(Class<HVUICollectionViewSupplementaryElementProtocol>)footClass{
	_footClass = footClass;
	if(self.showFoot){
		[self setSupplementaryElementViewClass:footClass forKind:UICollectionElementKindSectionFooter];
	}
}
- (void)setShowHead:(BOOL)showHead{
	_showHead = showHead;
	if(self.headClass){
		if(self.showHead){
			[self setSupplementaryElementViewClass:self.headClass forKind:UICollectionElementKindSectionHeader];
		}else{
			[self removeSupplementaryElementViewClassForKind:UICollectionElementKindSectionHeader];
		}
	}
}
- (void)setShowFoot:(BOOL)showFoot{
	_showFoot = showFoot;
	if(self.footClass){
		if(self.showFoot){
			[self setSupplementaryElementViewClass:self.footClass forKind:UICollectionElementKindSectionFooter];
		}else{
			[self removeSupplementaryElementViewClassForKind:UICollectionElementKindSectionFooter];
		}
	}
}
@end
