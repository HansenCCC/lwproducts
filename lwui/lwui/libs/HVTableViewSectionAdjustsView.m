//
//  HVTableViewSectionAdjustsView.m
//  hvui
//
//  Created by moon on 15/3/20.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVTableViewSectionAdjustsView.h"

@implementation HVTableViewSectionAdjustsView
DEF_SINGLETON(HVTableViewSectionAdjustsView);
+ (UIEdgeInsets)contentMargin{
	return UIEdgeInsetsMake(8, 16, 8, 16);
}
+ (HVTableViewSectionModel *)sectionModelWithHeadTitle:(NSString *)title{
	HVTableViewSectionModel *sm = [[HVTableViewSectionModel alloc] init];
	sm.showHeadView = YES;
	sm.headTitle = title;
	sm.showDefaultHeadView = NO;
	sm.headViewClass = self;
	return sm;
}
+ (HVTableViewSectionModel *)sectionModelWithFootTitle:(NSString *)title{
	HVTableViewSectionModel *sm = [[HVTableViewSectionModel alloc] init];
	sm.showFootView = YES;
	sm.footTitle = title;
	sm.showDefaultFootView = NO;
	sm.footViewClass = self;
	return sm;
}
+ (HVTableViewSectionModel *)sectionModelWithHeadTitle:(NSString *)headTitle footTitle:(NSString *)footTitle{
	HVTableViewSectionModel *sm = [[HVTableViewSectionModel alloc] init];
	sm.showHeadView = YES;
	sm.headTitle = headTitle;
	sm.showDefaultHeadView = NO;
	sm.headViewClass = self;
	
	sm.showFootView = YES;
	sm.footTitle = footTitle;
	sm.showDefaultFootView = NO;
	sm.footViewClass = self;
	return sm;
}

- (void)layoutSubviews{
	[super layoutSubviews];
	CGRect bounds = self.bounds;
	UIEdgeInsets insets = [self.class contentMargin];
	//title
	CGRect f1 = bounds;
	f1 = UIEdgeInsetsInsetRect(f1, insets);
	self.textLabel.frame = f1;
}
#pragma mark - delegate:HVTableViewSectionViewProtocol
+ (CGFloat)heightWithTableView:(UITableView *)tableView sectionModel:(HVTableViewSectionModel *)sectionModel kind:(HVTableViewSectionViewKind)kind{
	CGFloat height = [self dynamicHeightWithTableView:tableView sectionModel:sectionModel kind:kind viewShareInstance:[self sharedInstance] calBlock:^CGFloat(UITableView *tableView, HVTableViewSectionModel *sectionModel, HVTableViewSectionViewKind kind, HVTableViewSectionAdjustsView *view) {
		CGFloat height = kHVTableViewSectionViewDefaultHeight;
		UILabel *textLabel = view.textLabel;
		UIEdgeInsets insets = [self contentMargin];
		CGRect f1 = textLabel.frame;
		CGSize f1_size = [textLabel sizeThatFits:CGSizeMake(f1.size.width, 99999)];
		height = f1_size.height+insets.top+insets.bottom;
		height = ceil(height);//向上取整
		return height;
	}];
	return height;
}
@end
