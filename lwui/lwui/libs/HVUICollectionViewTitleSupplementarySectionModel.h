//
//  HVUICollectionViewTitleSupplementarySectionModel.h
//  hvui
//	含有head与foot文字的补充元素
//  Created by moon on 15/9/15.
//  Copyright (c) 2015年 heimavista. All rights reserved.
//

#import "HVUICollectionViewSectionModel.h"
#import "HVUICollectionViewSupplementaryElementProtocol.h"
@interface HVUICollectionViewTitleSupplementarySectionModel : HVUICollectionViewSectionModel
@property(nonatomic,assign) BOOL showHead;//是否显示head,默认为NO
@property(nonatomic,strong) NSString *headTitle;
@property(nonatomic,assign) Class<HVUICollectionViewSupplementaryElementProtocol> headClass;

@property(nonatomic,assign) BOOL showFoot;//是否显示foot,默认为NO
@property(nonatomic,strong) NSString *footTitle;
@property(nonatomic,assign) Class<HVUICollectionViewSupplementaryElementProtocol> footClass;
@end
