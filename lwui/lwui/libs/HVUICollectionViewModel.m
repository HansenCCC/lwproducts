//
//  HVUICollectionViewModel.m
//  hvui
//
//  Created by moon on 14/12/29.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "HVUICollectionViewModel.h"
#import <objc/runtime.h>

@implementation HVUICollectionViewModel
- (void)dealloc{
	
}
- (id)initWithCollectionView:(UICollectionView *)collectionView{
	if(self=[self init]){
		[self setCollectionViewDataSourceAndDelegate:collectionView];
	}
	return self;
}
- (HVCollectionSectionModel *)createEmptySectionModel{
	HVUICollectionViewSectionModel *section = [[HVUICollectionViewSectionModel alloc] init];
	return section;
}
- (void)addCellModel:(HVCollectionCellModel *)cellModel{
	if(!cellModel)return;
	HVUICollectionViewSectionModel *section = (HVUICollectionViewSectionModel *)[self.sectionModels lastObject];
	if(!section){
		section = (HVUICollectionViewSectionModel *)[self createEmptySectionModel];
		[self addSectionModel:section];
	}
	[section addCellModel:cellModel];
}
- (__kindof HVUICollectionViewCellModel *)cellModelAtIndexPath:(NSIndexPath *)indexpath{
	return (HVUICollectionViewCellModel *)[super cellModelAtIndexPath:indexpath];
}
- (__kindof HVUICollectionViewSectionModel *)sectionModelAtIndex:(NSInteger)index{
	return (HVUICollectionViewSectionModel *)[super sectionModelAtIndex:index];
}
- (__kindof HVUICollectionViewCellModel *)cellModelForSelectedCellModel{
	return (HVUICollectionViewCellModel *)[super cellModelForSelectedCellModel];
}
- (void)setCollectionViewDataSourceAndDelegate:(UICollectionView *)collectionView{
	self.collectionView = collectionView;
	collectionView.dataSource = self;
	collectionView.delegate = self;
}
- (void)setForwardDelegate:(id<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>)forwardDelegate{
	_forwardDelegate = forwardDelegate;
	if(self.collectionView.delegate==self){
		self.collectionView.delegate = nil;
		self.collectionView.delegate = self;//重新赋值一次,使得scrollview重新判断scrollViewDidScroll:方法的有无
	}
}
- (void)reloadCollectionViewData{
	[self.collectionView reloadData];
	if(self.allowsSelection){
		if(self.allowsMultipleSelection){
			NSArray *indexpaths = [self indexPathsForSelectedCellModels];
			for (NSIndexPath *indexpath in indexpaths) {
				[self.collectionView selectItemAtIndexPath:indexpath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
			}
		}else{
			NSIndexPath *indexpath = [self indexPathForSelectedCellModel];
			[self.collectionView selectItemAtIndexPath:indexpath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
		}
	}
	[self reloadCollectionViewBackgroundView];
}
- (void)addCellModel:(HVCollectionCellModel *)cellModel animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
	if(!cellModel)return;
	UICollectionView *collectionView = self.collectionView;
	[self addCellModel:cellModel];
	if(animated&&collectionView){
		HVCollectionSectionModel *sm = (HVCollectionSectionModel *)[self.sectionModels lastObject];
		NSIndexPath *indexpath = [NSIndexPath indexPathForItem:[sm numberOfCells]-1 inSection:self.sectionModels.count-1];
		[collectionView performBatchUpdates:^{
			if([collectionView numberOfSections]==0){//添加section
				[collectionView insertSections:[NSIndexSet indexSetWithIndex:0]];
			}
			[collectionView insertItemsAtIndexPaths:@[indexpath]];
		} completion:^(BOOL finished) {
			[self reloadCollectionViewBackgroundView];
			if(completion){
				completion(finished);
			}
		}];
	}else{
		[self reloadCollectionViewData];
		if(completion){
			completion(YES);
		}
	}
}
- (void)removeCellModel:(HVCollectionCellModel *)cellModel animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
	if(!cellModel)return;
	NSIndexPath *indexpath = [self indexPathOfCellModel:cellModel];
	if(indexpath){
		HVUICollectionViewSectionModel *sm = (HVUICollectionViewSectionModel *)[self sectionModelAtIndex:indexpath.section];
		[self removeCellModelAtIndexPath:indexpath];
		if(sm.numberOfCells==0){
			[self removeSectionModelAtIndex:indexpath.section];
		}
		UICollectionView *collectionView = self.collectionView;
		if(animated&&collectionView){
			UICollectionView *collectionView = self.collectionView;
			[collectionView performBatchUpdates:^{
				if(sm.numberOfCells==0){
					[collectionView deleteSections:[NSIndexSet indexSetWithIndex:indexpath.section]];
				}
				[collectionView deleteItemsAtIndexPaths:@[indexpath]];
			} completion:^(BOOL finished) {
				[self reloadCollectionViewBackgroundView];
				if(completion){
					completion(finished);
				}
			}];
		}else{
			[self reloadCollectionViewData];
			if(completion){
				completion(YES);
			}
		}
	}
}
- (void)removeCellModels:(NSArray<HVCollectionCellModel *> *)cellModels animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
	if(cellModels.count==0)return;
	NSArray<NSIndexPath *> *indexpaths = [self indexPathsOfCellModels:cellModels];
	if(indexpaths.count){
		NSMutableIndexSet *deletedSectionIndexs = [[NSMutableIndexSet alloc] init];
		for (HVCollectionCellModel *cm in cellModels) {
			HVUICollectionViewSectionModel *sm = (HVUICollectionViewSectionModel *)cm.sectionModel;
			[sm removeCellModel:cm];
			if(sm.numberOfCells==0){
				[deletedSectionIndexs addIndex:sm.indexInModel];
				[self removeSectionModel:sm];
			}
		}
		UICollectionView *collectionView = self.collectionView;
		if(animated&&collectionView){
			UICollectionView *collectionView = self.collectionView;
			[collectionView performBatchUpdates:^{
				if(deletedSectionIndexs.count!=0){
					[collectionView deleteSections:deletedSectionIndexs];
				}
				[collectionView deleteItemsAtIndexPaths:indexpaths];
			} completion:^(BOOL finished) {
				[self reloadCollectionViewBackgroundView];
				if(completion){
					completion(finished);
				}
			}];
		}else{
			[self reloadCollectionViewData];
			if(completion){
				completion(YES);
			}
		}
	}
}
- (void)moveCellModelAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath inCollectionViewBatchUpdatesBlock:(BOOL)isBatchUpdates{
	if([sourceIndexPath isEqual:destinationIndexPath])return;
	NSMutableArray<NSIndexPath *> *addedIndexPathes = [[NSMutableArray alloc] init];
	NSMutableArray<NSIndexPath *> *removeIndexPathes = [[NSMutableArray alloc] init];
	HVCollectionCellModel *sourceCellModel = [self cellModelAtIndexPath:sourceIndexPath];
	[self removeCellModelAtIndexPath:sourceIndexPath];
	[self insertCellModel:sourceCellModel atIndexPath:destinationIndexPath];
	[addedIndexPathes addObject:destinationIndexPath];
	[removeIndexPathes addObject:sourceIndexPath];
	if(isBatchUpdates){
		UICollectionView *collectionView = self.collectionView;
		[collectionView deleteItemsAtIndexPaths:removeIndexPathes];
		[collectionView insertItemsAtIndexPaths:addedIndexPathes];
	}
}
- (void)insertSectionModel:(HVUICollectionViewSectionModel *)sectionModel atIndex:(NSInteger)index animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
	if(!sectionModel)return;
	UICollectionView *collectionView = self.collectionView;
	NSIndexSet *set = [NSIndexSet indexSetWithIndex:index];
	NSInteger count = sectionModel.numberOfCells;
	NSMutableArray<NSIndexPath *> *indexpaths = [[NSMutableArray alloc] initWithCapacity:count];
	for (int i=0; i<count; i++) {
		NSIndexPath *indexpath = [NSIndexPath indexPathForItem:index inSection:index];
		[indexpaths addObject:indexpath];
	}
	if(animated&&collectionView){
		[collectionView performBatchUpdates:^{
			[collectionView insertSections:set];
			[collectionView insertItemsAtIndexPaths:indexpaths];
		} completion:^(BOOL finished) {
			[self reloadCollectionViewBackgroundView];
			if(completion){
				completion(finished);
			}
		}];
	}else{
		[self reloadCollectionViewData];
		if(completion){
			completion(YES);
		}
	}
}
- (void)removeSectionModel:(HVUICollectionViewSectionModel *)sectionModel animated:(BOOL)animated completion:(void (^)(BOOL finished))completion{
	if(!sectionModel)return;
	NSInteger index = sectionModel.indexInModel;
	UICollectionView *collectionView = self.collectionView;
	NSIndexSet *set = [NSIndexSet indexSetWithIndex:index];
	NSInteger count = sectionModel.numberOfCells;
	NSMutableArray<NSIndexPath *> *indexpaths = [[NSMutableArray alloc] initWithCapacity:count];
	for (int i=0; i<count; i++) {
		NSIndexPath *indexpath = [NSIndexPath indexPathForItem:index inSection:index];
		[indexpaths addObject:indexpath];
	}
	if(animated&&collectionView){
		[collectionView performBatchUpdates:^{
			[collectionView deleteSections:set];
			[collectionView deleteItemsAtIndexPaths:indexpaths];
		} completion:^(BOOL finished) {
			[self reloadCollectionViewBackgroundView];
			if(completion){
				completion(finished);
			}
		}];
	}else{
		[self reloadCollectionViewData];
		if(completion){
			completion(YES);
		}
	}
}
#pragma mark - empty background
- (UIView *)createEmptyBackgroundView{
	Class c = self.emptyBackgroundViewClass;
	UIView *view;
	if(c){
		view = [[c alloc] init];
	}
	return view;
}
- (void)reloadCollectionViewBackgroundView{
	if(!self.emptyBackgroundViewClass)return;
	if(self.numberOfCells==0){
		if(!self.emptyBackgroundView){
			self.emptyBackgroundView = [self createEmptyBackgroundView];
		}
		self.collectionView.backgroundView = self.emptyBackgroundView;
	}else{
		self.collectionView.backgroundView = nil;
	}
	if(self.whenReloadBackgroundView) {
		self.whenReloadBackgroundView(self);
	}
}
#pragma mark - delegate:UICollectionViewDataSource,UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
	self.collectionView = collectionView;
	HVUICollectionViewSectionModel *sm = [self sectionModelAtIndex:section];
	NSInteger number = [sm numberOfCells];
	return number;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
	HVUICollectionViewCellModel *cm = (HVUICollectionViewCellModel *)[self cellModelAtIndexPath:indexPath];
	
	//使用静态单元格视图
	UICollectionViewCell<HVUICollectionViewCellProtocol> *staticCell = cm.staticCollectionViewCell;
	if(staticCell){
		[cm displayCell:staticCell];
		return staticCell;
	}
	
	Class cellClass = cm.cellClass;
	[collectionView registerClass:cellClass forCellWithReuseIdentifier:cm.reuseIdentity];
	UICollectionViewCell<HVUICollectionViewCellProtocol> *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cm.reuseIdentity forIndexPath:indexPath];
	[cm displayCell:cell];
	return cell;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
	NSInteger number = [self numberOfSections];
	return number;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
	HVUICollectionViewSectionModel *sm = (HVUICollectionViewSectionModel *)[self sectionModelAtIndex:indexPath.section];
	Class aClass = [sm supplementaryElementViewClassForKind:kind];
	if(!aClass){
		return nil;
	}
	[collectionView registerClass:aClass forSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(aClass)];
	UICollectionReusableView<HVUICollectionViewSupplementaryElementProtocol> *view = (UICollectionReusableView<HVUICollectionViewSupplementaryElementProtocol> *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(aClass) forIndexPath:indexPath];
	[sm displaySupplementaryElementView:view forKind:kind];
	return view;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(9_0){
	BOOL move = NO;
	HVUICollectionViewCellModel *cellModel = (HVUICollectionViewCellModel *)[self cellModelAtIndexPath:indexPath];
	move = cellModel.canMove;
	return move;
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath NS_AVAILABLE_IOS(9_0){
	HVUICollectionViewCellModel *srcTablecellModel = (HVUICollectionViewCellModel *)[self cellModelAtIndexPath:sourceIndexPath];
	HVUICollectionViewCellModel *dstTablecellModel = (HVUICollectionViewCellModel *)[self cellModelAtIndexPath:destinationIndexPath];
	BOOL handed = NO;
	HVUICollectionViewCellModelBlockM handler = srcTablecellModel.whenMove?:dstTablecellModel.whenMove;
	if(handler){
		handler(srcTablecellModel,dstTablecellModel);
		handed = YES;
	}
	if([self.forwardDataSource respondsToSelector:_cmd]){
		[self.forwardDataSource collectionView:collectionView moveItemAtIndexPath:destinationIndexPath toIndexPath:destinationIndexPath];
		handed = YES;
	}
	if(!handed){
		[self moveCellModelAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
	}
}
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//	if([self.forwardDelegate respondsToSelector:_cmd]){
//		return [self.forwardDelegate collectionView:collectionView shouldSelectItemAtIndexPath:indexPath];
//	}
//	HVUICollectionViewCellModel *cm = [self cellModelAtIndexPath:indexPath];
//	if(cm.selected){
//		return NO;
//	}else{
//		return YES;
//	}
//}
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//	if([self.forwardDelegate respondsToSelector:_cmd]){
//		return [self.forwardDelegate collectionView:collectionView shouldDeselectItemAtIndexPath:indexPath];
//	}
//	HVUICollectionViewCellModel *cm = [self cellModelAtIndexPath:indexPath];
//	if(cm.selected){
//		return YES;
//	}else{
//		return NO;
//	}
//}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
	if(cell
	   &&[cell conformsToProtocol:@protocol(HVUICollectionViewCellProtocol)]
	   &&[cell respondsToSelector:@selector(collectionView:didSelectCell:)]
	   ){
		[(UICollectionViewCell<HVUICollectionViewCellProtocol> *)cell collectionView:collectionView didSelectCell:YES];
	}
	HVUICollectionViewCellModel *cm = [self cellModelAtIndexPath:indexPath];
	[self selectCellModel:cm];
	if(cm.whenSelected){
		cm.whenSelected(cm,YES);
	}
	if(cm.whenClick){
		cm.whenClick(cm);
	}
	if([self.forwardDelegate respondsToSelector:_cmd]){
		[self.forwardDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
	}
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
	UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
	if(cell
	   &&[cell conformsToProtocol:@protocol(HVUICollectionViewCellProtocol)]
	   &&[cell respondsToSelector:@selector(collectionView:didSelectCell:)]
	   ){
		[(UICollectionViewCell<HVUICollectionViewCellProtocol> *)cell collectionView:collectionView didSelectCell:NO];
	}
	HVUICollectionViewCellModel *cm = [self cellModelAtIndexPath:indexPath];
	[self deselectCellModel:cm];
	if(cm.whenSelected){
		cm.whenSelected(cm,NO);
	}
	if([self.forwardDelegate respondsToSelector:_cmd]){
		[self.forwardDelegate collectionView:collectionView didDeselectItemAtIndexPath:indexPath];
	}
}
#pragma mark - delegate:UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
	CGRect bounds = collectionView.bounds;
	CGSize size = CGSizeZero;
	if([collectionViewLayout isKindOfClass:[UICollectionViewFlowLayout class]]){
		UICollectionViewFlowLayout *flowlayout = (UICollectionViewFlowLayout *)collectionViewLayout;
		if(CGSizeEqualToSize(bounds.size,CGSizeZero)){//flowlayout布局时,0尺寸会出现"the item height must be less that the height of the UICollectionView minus the section insets top and bottom values."的警告,因此直接设置0的itemsize
			size = CGSizeZero;
		}else{
			size = flowlayout.itemSize;
		}
	}
	if([self.forwardDelegate respondsToSelector:_cmd]){
		size = [self.forwardDelegate collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
	}else{
		Class cellClass;
		HVUICollectionViewCellModel *cm = [self cellModelAtIndexPath:indexPath];
		//使用静态单元格视图
		UICollectionViewCell<HVUICollectionViewCellProtocol> *staticCell = cm.staticCollectionViewCell;
		if(staticCell){
			cellClass = staticCell.class;
		}else{
			cellClass = cm.cellClass;
		}
		if([cellClass respondsToSelector:@selector(sizeWithCollectionView:collectionCellModel:)]){
			size = [cellClass sizeWithCollectionView:collectionView collectionCellModel:cm];
		}
	}
	return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
	NSString *kind = UICollectionElementKindSectionHeader;
	UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
	CGSize size = flowLayout.headerReferenceSize;
	
	if([self.forwardDelegate respondsToSelector:_cmd]){
		size = [self.forwardDelegate collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
	}else{
		HVUICollectionViewSectionModel *sm = (HVUICollectionViewSectionModel *)[self sectionModelAtIndex:section];
		Class aClass = [sm supplementaryElementViewClassForKind:kind];
		if(aClass&&[aClass conformsToProtocol:@protocol(HVUICollectionViewSupplementaryElementProtocol)]){
			if([aClass respondsToSelector:@selector(referenceSizeWithCollectionView:collectionSectionModel:forKind:)]){
				size = [aClass referenceSizeWithCollectionView:collectionView collectionSectionModel:sm forKind:kind];
			}
		}
	}
	return size;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
	NSString *kind = UICollectionElementKindSectionFooter;
	UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
	CGSize size = flowLayout.footerReferenceSize;
	
	if([self.forwardDelegate respondsToSelector:_cmd]){
		size = [self.forwardDelegate collectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
	}else{
		HVUICollectionViewSectionModel *sm = (HVUICollectionViewSectionModel *)[self sectionModelAtIndex:section];
		Class aClass = [sm supplementaryElementViewClassForKind:kind];
		if(aClass&&[aClass conformsToProtocol:@protocol(HVUICollectionViewSupplementaryElementProtocol)]){
			if([aClass respondsToSelector:@selector(referenceSizeWithCollectionView:collectionSectionModel:forKind:)]){
				size = [aClass referenceSizeWithCollectionView:collectionView collectionSectionModel:sm forKind:kind];
			}
		}
	}
	return size;
}
#pragma mark - Forward Invocations
/**
 *根據指定的Selector返回該類支持的方法簽名,一般用於prototol或者消息轉發forwardInvocation:中NSInvocation參數的methodSignature屬性
 注:系統調用- (void)forwardInvocation:(NSInvocation *)invocation方法前,會先調用此方法獲取NSMethodSignature,然後生成方法所需要的NSInvocation
 */
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
	NSMethodSignature *signature = [super methodSignatureForSelector:selector];
	if (signature == nil) {
		id delegate = self.forwardDelegate;
		if ([delegate respondsToSelector:selector]) {
			signature = [delegate methodSignatureForSelector:selector];
		}else{
			delegate = self.forwardDataSource;
			if ([delegate respondsToSelector:selector]) {
				signature = [delegate methodSignatureForSelector:selector];
			}
		}
	}
	return signature;
}
- (BOOL)respondsToSelector:(SEL)selector {
	if ([super respondsToSelector:selector]) {
		return YES;
	} else {
		if([self.forwardDelegate respondsToSelector:selector]){
			return YES;
		}else if([self.forwardDataSource respondsToSelector:selector]){
			return YES;
		}
	}
	return NO;
}
/**
 *對調用未定義的方法進行消息重定向
 */
- (void)forwardInvocation:(NSInvocation *)invocation {
	BOOL didForward = NO;
	id delegate = self.forwardDelegate;
	if ([delegate respondsToSelector:invocation.selector]) {
		[invocation invokeWithTarget:delegate];
		didForward = YES;
	}
	if(!didForward){
		delegate = self.forwardDataSource;
		if ([delegate respondsToSelector:invocation.selector]) {
			[invocation invokeWithTarget:delegate];
			didForward = YES;
		}
	}
	if (!didForward) {
		[super forwardInvocation:invocation];
	}
}
@end


@implementation HVUICollectionViewModel(NS_DEPRECATED_IOS)//将要被废弃的接口
- (HVUICollectionViewSectionModel *)addListedCellModel:(HVUICollectionViewCellModel *)cellModel{
	[self addCellModel:cellModel];
	return [self.sectionModels lastObject];
}
- (void)selectSingleCellModel:(HVUICollectionViewCellModel *)cellModel{
	for (HVUICollectionViewCellModel *cm in [self allCellModels]) {
		if(cm==cellModel){
			cm.selected = YES;
		}else{
			cm.selected = NO;
		}
	}
}
- (HVUICollectionViewCellModel *)selectedCellModel{
	HVUICollectionViewCellModel *cm = [[self selectedCellModels] firstObject];
	return cm;
}
- (NSArray *)selectedCellModels{
	NSMutableArray *cellModels = [[NSMutableArray alloc] init];
	for (HVUICollectionViewCellModel *cm in [self allCellModels]) {
		if(cm.selected){
			[cellModels addObject:cm];
		}
	}
	return cellModels;
}

@end
