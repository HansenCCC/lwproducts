//
//  HVCollectionCellModel.h
//  hvui
//
//  Created by moon on 14/11/19.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class HVCollectionSectionModel,HVCollectionModel;
@interface HVCollectionCellModel : NSObject{
	@protected
	__weak HVCollectionSectionModel *_sectionModel;
}
@property(nonatomic,readonly) __kindof HVCollectionModel *collectionModel;//集合模型对象
@property(nonatomic,strong) id userInfo;//自定義的擴展對象
@property(nonatomic,assign) BOOL selected;
@property(nonatomic,readonly) NSInteger indexInSectionModel;
@property(nonatomic,readonly) NSIndexPath *indexPathInModel;
@property(nonatomic,readonly) NSIndexPath *indexPathOfPreCell;//上一个单元格的indexpath
@property(nonatomic,readonly) NSIndexPath *indexPathOfNextCell;//下一个单元格的indexpath
//弱引用上層的分組對象
- (void)setSectionModel:(HVCollectionSectionModel *)sectionModel;
- (__kindof HVCollectionSectionModel *)sectionModel;

- (NSComparisonResult)compare:(HVCollectionCellModel *)otherObject;


@end
