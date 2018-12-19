//
//  HVTableViewCellModel.m
//  hvui
//
//  Created by moon on 14-4-1.
//  Copyright (c) 2014年 heimavista.com. All rights reserved.
//

#import "HVTableViewCellModel.h"
#import "HVTableViewModel.h"
#import "HVTableViewCellProtocol.h"
#import "UITableViewCell+HVTableViewCell.h"

@implementation HVTableViewCellModel
- (id)init{
	if(self=[super init]){
		self.cellClass = [UITableViewCell class];
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
- (__kindof HVTableViewSectionModel *)sectionModel{
	HVCollectionSectionModel *sectionModel = [super sectionModel];
	if([sectionModel isKindOfClass:[HVTableViewSectionModel class]]){
		return (HVTableViewSectionModel *)sectionModel;
	}
	return nil;
}
- (void)displayCell:(UITableViewCell<HVTableViewCellProtocol> *)cell{
	self.tableViewCell = cell;
	cell.accessoryType = self.accessoryType;
	cell.cellModel = self;
	if(self.whenShow){
		self.whenShow(self,cell);
	}
	[cell setNeedsLayout];
}
- (NSString *)reuseIdentity{
	if(_reuseIdentity==nil){
		_reuseIdentity = NSStringFromClass(self.cellClass);
	}
	return _reuseIdentity;
}
- (void)refresh{
	NSIndexPath *indexPath = [self.tableViewModel indexPathOfCellModel:self];
	if(indexPath){
		[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
	}
}
- (void)refreshWithAnimated:(BOOL)animated{
	NSIndexPath *indexPath = [self.tableViewModel indexPathOfCellModel:self];
	if(indexPath){
		[self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animated?UITableViewRowAnimationAutomatic:UITableViewRowAnimationNone];
	}
}
- (void)deselectCellWithAnimated:(BOOL)animated {
	NSIndexPath *indexPath = [self.tableViewModel indexPathOfCellModel:self];
	if(indexPath){
		[self.tableView deselectRowAtIndexPath:indexPath animated:animated];
	}
}

#pragma debug
- (NSString *)description{
	return [NSString stringWithFormat:@"%@:[cellClass:%@,userInfo:%@]",NSStringFromClass(self.class),NSStringFromClass(self.cellClass),self.userInfo];
}
- (void)dealloc{
//	HVLog(@"deallocHVTableViewCellModel:%@", self);
}
@end

@implementation HVTableViewCellModel(NS_DEPRECATED_IOS)
- (HVTableViewSectionModel *)tableSectionModel{
	return (HVTableViewSectionModel *)[self sectionModel];
}
@end
