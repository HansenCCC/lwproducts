//
//  HVCollectionCellModel.m
//  hvui
//
//  Created by moon on 14/11/19.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "HVCollectionCellModel.h"
#import "HVCollectionSectionModel.h"
#import "HVCollectionModel.h"
@implementation HVCollectionCellModel
- (void)dealloc{
	
}
- (NSIndexPath *)indexPathOfPreCell{
	NSIndexPath *preIndexPath;
	NSInteger row = [self indexInSectionModel];
	NSInteger section = [self.sectionModel indexInModel];
	if(row>0){
		preIndexPath = [NSIndexPath indexPathForRow:row-1 inSection:section];
	}else{
		for (NSInteger i=section-1; i>=0; i++) {
			HVCollectionSectionModel *sm = [self.collectionModel sectionModelAtIndex:i];
			if(sm.numberOfCells>0){
				preIndexPath = [NSIndexPath indexPathForRow:sm.numberOfCells-1 inSection:i];
				break;
			}
		}
	}
	return preIndexPath;
}
- (NSIndexPath *)indexPathOfNextCell{
	NSIndexPath *nextIndexPath;
	NSInteger row = [self indexInSectionModel];
	NSInteger section = [self.sectionModel indexInModel];
	if(row+1<self.sectionModel.numberOfCells){
		nextIndexPath = [NSIndexPath indexPathForRow:row+1 inSection:section];
	}else{
		NSInteger sectionCount = [self.collectionModel numberOfSections];
		for (NSInteger i=section+1; i<sectionCount; i++) {
			HVCollectionSectionModel *sm = [self.collectionModel sectionModelAtIndex:i];
			if(sm.numberOfCells>0){
				nextIndexPath = [NSIndexPath indexPathForRow:0 inSection:i];
				break;
			}
		}
	}
	return nextIndexPath;
}
- (NSInteger)indexInSectionModel{
	NSInteger index = [self.sectionModel indexOfCellModel:self];
	return index;
}
- (NSIndexPath *)indexPathInModel{
	NSInteger cellIndex = [self indexInSectionModel];
	NSInteger sectionIndex = [self.sectionModel indexInModel];
	NSIndexPath *indexPath;
	if(cellIndex!=NSNotFound&&sectionIndex!=NSNotFound){
		indexPath = [NSIndexPath indexPathForRow:cellIndex inSection:sectionIndex];
	}
	return indexPath;
}
- (HVCollectionModel *)collectionModel{
	HVCollectionModel *model = [[self sectionModel] collectionModel];
	return model;
}
- (void)setSectionModel:(HVCollectionSectionModel *)sectionModel{
	_sectionModel = sectionModel;
}
- (HVCollectionSectionModel *)sectionModel{
	return _sectionModel;
}
- (NSComparisonResult)compare:(HVCollectionCellModel *)otherObject{
	NSComparisonResult r = [self.sectionModel compare:otherObject.sectionModel];
	if(r==NSOrderedSame){
		NSInteger row1 = [self.sectionModel indexOfCellModel:self];
		NSInteger row2 = [otherObject.sectionModel indexOfCellModel:otherObject];
		if(row1<row2){
			r = NSOrderedAscending;
		}else if(row1>row2){
			r = NSOrderedDescending;
		}
	}
	return r;
}
@end
