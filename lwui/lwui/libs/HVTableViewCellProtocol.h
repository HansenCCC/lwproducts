//
//  HVTableViewCellProtocol.h
//  hvui
//	HVTableViewCellModel對應的UITableViewCell視圖要實現的delegate
//  Created by moon on 14/11/13.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVTableViewCellModel.h"

#ifndef DEF_HVTableViewCellModel
#define DEF_HVTableViewCellModel(clazz,property) \
- (HVTableViewCellModel *)cellModel{\
	return self.property;\
}\
- (void)setCellModel:(HVTableViewCellModel *)cellModel{\
	self.property = (clazz *)cellModel;\
}
#endif

@protocol HVTableViewCellProtocol <NSObject>

/**
 *  根據cellmodel,計算出cell視圖的高度
 *
 *  @param tableView 外層tableview
 *  @param cellModel 單元格數據
 *
 *  @return 高度值
 */
+ (CGFloat)heightWithTableView:(UITableView *)tableView cellModel:(HVTableViewCellModel *)cellModel;
@property(nonatomic,strong) HVTableViewCellModel *cellModel;//cell的數據模型對象
@optional
//选中/取消选中单元格
- (void)tableView:(UITableView *)tableView didSelectCell:(BOOL)selected;
@end
