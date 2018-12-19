//
//  UITableViewCell+HVTableViewCell.m
//  hvui
//
//  Created by moon on 14/11/13.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "UITableViewCell+HVTableViewCell.h"
#import <objc/runtime.h>

@implementation UITableViewCell (HVTableViewCell)
#pragma mark - deleagte:HVTableViewCellProtocol
- (HVTableViewCellModel *)cellModel{
	HVTableViewCellModel *cellModel = objc_getAssociatedObject( self, "UITableViewCell.HVTableViewCell.cellModel");
	return cellModel;
}
- (void)setCellModel:(HVTableViewCellModel *)cellModel{
	objc_setAssociatedObject( self, "UITableViewCell.HVTableViewCell.cellModel", cellModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC );
}
+ (CGFloat)heightWithTableView:(UITableView *)tableView cellModel:(HVTableViewCellModel *)cellModel{
	return 44;
}
+ (CGFloat)dynamicHeightWithTableView:(UITableView *)tableView cellModel:(HVTableViewCellModel *)cellModel cellShareInstance:(UITableViewCell<HVTableViewCellProtocol> *)cell calBlock:(CGFloat(^)(UITableView *tableView,HVTableViewCellModel *cellModel,id cell))block{
	CGFloat height = 44;
	CGRect bounds = tableView.bounds;
	if(!CGRectIsEmpty(bounds)){
		cell.bounds = bounds;
		cell.cellModel = cellModel;
		[cell setNeedsLayout];
		[cell layoutIfNeeded];
		if(block){
			height = block(tableView,cellModel,cell);
		}
		if(tableView.separatorStyle!=UITableViewCellSeparatorStyleNone){
			height += 0.5;//添加上0.5的分隔线
		}
		height = ceil(height);//向上取整
		cell.cellModel = nil;
	}
	return height;
}
@end
