//
//  HVUICollectionViewCellModel.h
//  hvui
//
//  Created by moon on 14/12/29.
//  Copyright (c) 2014年 heimavista. All rights reserved.
//

#import "HVCollectionCellModel.h"
#import "HVUICollectionViewCellProtocol.h"

@class HVUICollectionViewCellModel,HVUICollectionViewSectionModel,HVUICollectionViewModel;
typedef void(^HVUICollectionViewCellModelBlockC)(__kindof HVUICollectionViewCellModel *cellModel);
typedef void(^HVUICollectionViewCellModelBlockS)(__kindof HVUICollectionViewCellModel *cellModel,BOOL selected);
typedef BOOL(^HVUICollectionViewCellModelBlockM)(__kindof HVUICollectionViewCellModel *src,
										  __kindof HVUICollectionViewCellModel *dst);	//移動數據時觸發的動作

typedef BOOL(^HVUICollectionViewCellModelBlockD)(__kindof HVUICollectionViewCellModel *cellModel);	//刪除數據時觸發的動作

@interface HVUICollectionViewCellModel : HVCollectionCellModel
@property(nonatomic,assign) Class<HVUICollectionViewCellProtocol> cellClass;
@property(nonatomic,strong) __kindof UICollectionViewCell<HVUICollectionViewCellProtocol> *staticCollectionViewCell;//静态的单元格视图,此时不会使用cellClass去实现化单元格了
@property(nonatomic,strong) NSString *reuseIdentity;//用於列表重用單元格視圖時的標誌符,默認為NSStringFromCGClass(self.class)

@property(nonatomic,assign) BOOL canDelete;//是否可以被删除,默认为NO
@property(nonatomic,assign) BOOL canMove;//是否可以被移動,默认为 NO
@property(nonatomic,copy) HVUICollectionViewCellModelBlockM whenMove;//移動位置觸發
@property(nonatomic,copy) HVUICollectionViewCellModelBlockD whenDelete;//删除触发

@property(nonatomic,assign) __kindof UICollectionViewCell<HVUICollectionViewCellProtocol> *collectionViewCell;//弱引用单元格视图
@property(nonatomic,readonly) UICollectionView *collectionView;
@property(nonatomic,copy) HVUICollectionViewCellModelBlockC whenClick;//点击时被触发
@property(nonatomic,copy) HVUICollectionViewCellModelBlockS whenSelected;//被触控事件选中时触发
 - (__kindof HVUICollectionViewSectionModel *)sectionModel;
 - (__kindof HVUICollectionViewModel *)collectionModel;
/**
 *  根据模型显示视图
 *	
 *  @param cell 视图对象
 */
- (void)displayCell:(UICollectionViewCell<HVUICollectionViewCellProtocol> *)cell;

/**
 *  刷新视图
 */
- (void)refresh;

//移除单元格
- (void)removeCellModelWithAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion;
@end
