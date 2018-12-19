//
//  HVUICollectionViewSupplementaryView.m
//  hvui
//
//  Created by moon on 15/9/15.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUICollectionViewSupplementaryView.h"

@implementation HVUICollectionViewSupplementaryView
#pragma mark - protocol:HVUICollectionViewSupplementaryElementProtocol
- (void)setCollectionSectionModel:(HVUICollectionViewSectionModel *)sectionModel forKind:(NSString *)kind{
	self.sectionModel = sectionModel;
	self.kind = kind;
}
+ (CGSize)referenceSizeWithCollectionView:(UICollectionView *)collectionView collectionSectionModel:(HVUICollectionViewSectionModel *)sectionModel forKind:(NSString *)kind{
	return CGSizeZero;
}
@end