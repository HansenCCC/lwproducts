//
//  HVTableViewSectionView.m
//  hvui
//
//  Created by moon on 14/11/13.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "HVTableViewSectionView.h"

@implementation HVTableViewSectionView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
		[self _myInit];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
	if (self=[super initWithCoder:aDecoder]) {
		[self _myInit];
	}
	return self;
}
- (void)_myInit{
	self.textLabel = [[UILabel alloc] init];
	self.textLabel.font = [UIFont systemFontOfSize:15];
	self.textLabel.textColor = [UIColor lightGrayColor];
	self.textLabel.numberOfLines = 0;
	self.textLabel.textAlignment = NSTextAlignmentLeft;
	[self addSubview:self.textLabel];
}
- (void)layoutSubviews{
	[super layoutSubviews];
	CGRect bounds = self.bounds;
	//text
	CGRect f1 = bounds;
	f1.origin.x = 16;//left-margin
	self.textLabel.frame = f1;
}
#pragma mark - delegate:HVTableViewSectionViewProtocol
+ (CGFloat)heightWithTableView:(UITableView *)tableView sectionModel:(HVTableViewSectionModel *)sectionModel kind:(HVTableViewSectionViewKind)kind{
	CGFloat height = kHVTableViewSectionViewDefaultHeight;
	return height;
}
- (void)setSectionModel:(HVTableViewSectionModel *)sectionModel kind:(HVTableViewSectionViewKind)kind{
	self.textLabel.text = kind==HVTableViewSectionViewKindOfHead?sectionModel.headTitle:sectionModel.footTitle;
	[self setNeedsLayout];
	[self setNeedsDisplay];
}
@end
@implementation UIView(HVTableViewSectionViewProtocol)
/**
 *  返回动态高度,一般是使用单例cell进行动态高度计算.block中只需要计算高度,不需要再配置单例cell的bounds,cellModel等属性
 *
 *  @param tableView	列表
 *  @param sectionModel 分组数据
 *  @param kind			分组数据类别
 *  @param view			分组视图单例对象
 *  @param block		计算动态高度的block
 *
 *  @return 动态高度
 */
+ (CGFloat)dynamicHeightWithTableView:(UITableView *)tableView sectionModel:(HVTableViewSectionModel *)sectionModel kind:(HVTableViewSectionViewKind)kind viewShareInstance:(UIView<HVTableViewSectionViewProtocol> *)view calBlock:(CGFloat(^)(UITableView *tableView,HVTableViewSectionModel *sectionModel,HVTableViewSectionViewKind kind,id view))block{
	CGFloat height = 0;
	CGRect bounds = tableView.bounds;
	if(!CGRectIsEmpty(bounds)){
		view.bounds = bounds;
		[view setSectionModel:sectionModel kind:kind];
		[view setNeedsLayout];
		[view layoutIfNeeded];
		if(block){
			height = block(tableView,sectionModel,kind,view);
		}
		height = ceil(height);//向上取整
		[view setSectionModel:nil kind:kind];
	}
	return height;
}
@end
