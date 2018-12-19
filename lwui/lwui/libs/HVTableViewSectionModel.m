//
//  HVTableViewSectionModel.m
//  hvui
//
//  Created by moon on 14-4-1.
//  Copyright (c) 2014年 heimavista.com. All rights reserved.
//

#import "HVTableViewSectionModel.h"
#import "HVTableViewCellModel.h"
#import "HVTableViewModel.h"
#import "HVTableViewSectionViewProtocol.h"
#import "HVTableViewSectionView.h"

@implementation HVTableViewSectionModel
- (id)init{
	if (self=[super init]) {
		self.headViewClass = [HVTableViewSectionView class];
		self.footViewClass = [HVTableViewSectionView class];
	}
	return self;
}
- (UITableView *)tableView{
	return self.tableViewModel.tableView;
}
- (HVTableViewModel *)tableViewModel{
	HVCollectionModel *collectionModel = [super collectionModel];
	if([collectionModel isKindOfClass:[HVTableViewModel class]]){
		return (HVTableViewModel *)collectionModel;
	}
	return nil;
}
- (void)setTableViewModel:(HVTableViewModel *)tableViewModel{
	self.collectionModel = tableViewModel;
}
- (__kindof HVTableViewCellModel *)cellModelAtIndex:(NSInteger)index{
	HVCollectionCellModel *cellModel = [super cellModelAtIndex:index];
	if([cellModel isKindOfClass:[HVTableViewCellModel class]]){
		return (HVTableViewCellModel *)cellModel;
	}
	return nil;
 }
- (id)initWithBlankHeadView:(CGFloat)height{
	if(self=[self init]){
		[self showDefaultHeadViewWithHeight:height];
		[self showDefaultFootViewWithHeight:0.1];
	}
	return self;
}
- (id)initWithBlankFootView:(CGFloat)height{
	if(self=[self init]){
		[self showDefaultHeadViewWithHeight:0.1];
		[self showDefaultFootViewWithHeight:height];
	}
	return self;
}
- (id)initWithBlankHeadView:(CGFloat)headViewHeight footView:(CGFloat)footViewHeight{
	if(self=[self init]){
		[self showDefaultHeadViewWithHeight:headViewHeight];
		[self showDefaultFootViewWithHeight:footViewHeight];
	}
	return self;
}
- (void)showDefaultHeadViewWithHeight:(CGFloat)height{
	self.showHeadView = YES;
	self.showDefaultHeadView = YES;
	self.headViewHeight = height;
}
- (void)showDefaultFootViewWithHeight:(CGFloat)height{
	self.showFootView = YES;
	self.showDefaultFootView = YES;
	self.footViewHeight = height;
}
- (void)displayHeadView:(UIView<HVTableViewSectionViewProtocol> *)view{
	[view setSectionModel:self kind:HVTableViewSectionViewKindOfHead];
	if(self.whenShowHeadView){
		self.whenShowHeadView(self,view);
	}
	[view setNeedsLayout];
}
- (void)displayFootView:(UIView<HVTableViewSectionViewProtocol> *)view{
	[view setSectionModel:self kind:HVTableViewSectionViewKindOfFoot];
	if(self.whenShowFootView){
		self.whenShowFootView(self,view);
	}
	[view setNeedsLayout];
}

- (void)refresh{
	if (self.tableView) {
		NSIndexSet *set = [self.tableViewModel indexSetOfSectionModel:self];
		if(set){
			[self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
		}
	}
}
#pragma debug
- (NSString *)description{
	return [NSString stringWithFormat:@"%@:[indexTitle:%@,showHeadView:%d,headTitle:%@,headViewHeight:%f,showFootView:%d,footTitle:%@,footViewHeight:%f,cells:%@,userInfo:%@]",NSStringFromClass(self.class),self.indexTitle,self.showHeadView,self.headTitle,self.headViewHeight,self.showFootView,self.footTitle,self.footViewHeight,self.cellModels,self.userInfo];
}
- (void)dealloc{
//	HVLog(@"deallocHVTableViewSectionModel:%@", self);
}
@end

@implementation HVTableViewSectionModel(NS_DEPRECATED_IOS)//将要被废弃的接口
- (void)setCells:(NSMutableArray *)cells{
	[super setCellModels:cells];
}
- (NSMutableArray *)cells{
	return [self mutableCellModels];
}
- (void)addCellModel:(HVTableViewCellModel *)cellModel atIndex:(NSInteger)index{
	[self insertCellModel:cellModel atIndex:index];
}
- (void)removeAllCells{
	[self removeAllCellModels];
}
@end
