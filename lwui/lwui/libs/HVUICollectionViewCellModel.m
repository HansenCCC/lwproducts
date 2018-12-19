//
//  HVUICollectionViewCellModel.m
//  hvui
//
//  Created by moon on 14/12/29.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "HVUICollectionViewCellModel.h"
#import "HVUICollectionViewModel.h"
#import "HVUICollectionViewSectionModel.h"
@implementation HVUICollectionViewCellModel
- (__kindof HVUICollectionViewSectionModel *)sectionModel{
	return (HVUICollectionViewSectionModel *)[super sectionModel];
}
- (__kindof HVUICollectionViewModel *)collectionModel{
	return (HVUICollectionViewModel *)[super collectionModel];
}
- (UICollectionView *)collectionView{
	return ((HVUICollectionViewModel *)[self collectionModel]).collectionView;
}
- (NSString *)reuseIdentity{
	if(!_reuseIdentity){
		_reuseIdentity = NSStringFromClass(self.cellClass);
	}
	return _reuseIdentity;
}
- (void)displayCell:(UICollectionViewCell<HVUICollectionViewCellProtocol> *)cell{
	self.collectionViewCell = cell;
	cell.collectionCellModel = self;
	[cell setNeedsLayout];
}
- (void)refresh{
	NSIndexPath *indexPath = [[self collectionModel] indexPathOfCellModel:self];
	if(indexPath){
		[self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
	}
}
- (void)removeCellModelWithAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
	[[self collectionModel] removeCellModel:self animated:animated completion:completion];
}
@end
