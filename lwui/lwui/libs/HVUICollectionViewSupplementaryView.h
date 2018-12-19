//
//  HVUICollectionViewSupplementaryView.h
//  hvui
//	集合分组的补充元素视图的基类
//  Created by moon on 15/9/15.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVUICollectionViewSupplementaryElementProtocol.h"
#import "HVUICollectionViewSectionModel.h"
@interface HVUICollectionViewSupplementaryView : UICollectionReusableView<HVUICollectionViewSupplementaryElementProtocol>
@property(nonatomic,strong) __kindof HVUICollectionViewSectionModel *sectionModel;
@property(nonatomic,strong) NSString *kind;
@end
