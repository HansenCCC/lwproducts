//
//  HVTableViewSectionViewProtocol.h
//  hvui
//
//  Created by moon on 14/11/13.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HVTableViewSectionModel.h"

typedef enum{
	HVTableViewSectionViewKindOfHead=0,	//頭部
	HVTableViewSectionViewKindOfFoot=1	//尾部
} HVTableViewSectionViewKind;

@protocol HVTableViewSectionViewProtocol <NSObject>
/**
 *  返回視圖的高度
 *
 *  @param tableView    外層的tableview
 *  @param sectionModel 分組數據模型
 *  @param kind         視圖的類型
 *
 *  @return 高度值
 */
+ (CGFloat)heightWithTableView:(UITableView *)tableView sectionModel:(HVTableViewSectionModel *)sectionModel kind:(HVTableViewSectionViewKind)kind;
/**
 *  設置分組模型與顯示類型
 *
 *  @param sectionModel 分組模型
 *  @param kind         類型
 */
- (void)setSectionModel:(HVTableViewSectionModel *)sectionModel kind:(HVTableViewSectionViewKind)kind;
@end
