//
//  LWUISegmentedView.m
//  LWcheng
//
//  Created by 程恒盛 on 17/1/23.
//  Copyright © 2017年 力王. All rights reserved.
//

#import "LWUISegmentedView.h"
#import "UIScrollView+LWUI.h"
@interface LWUISegmentedView ()
@property(nonatomic, strong) HVUICollectionViewModel *model;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property(nonatomic, strong) UIView *markView;

@end

@implementation LWUISegmentedView
-(instancetype)init{
    if (self = [super init]) {
        self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.flowLayout.minimumLineSpacing = 0.f;
        self.flowLayout.minimumInteritemSpacing = 0.f;
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        self.model = [[HVUICollectionViewModel alloc] initWithCollectionView:self.collectionView];
        [self addSubview:self.collectionView];
        self.collectionView.backgroundColor = [UIColor clearColor];
        
        self.markView = [[UIView alloc] init];
        self.markView.backgroundColor = [UIColor redColor];
        self.markView.hidden = YES;
        [self.collectionView addSubview:self.markView];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        
        self.collectionView.contentInset = UIEdgeInsetsZero;
    }
    return self;
}
-(void)addSegmentedModel:(HVCollectionCellModel *)cellModel{
    [self.model addCellModel:cellModel];
}
-(void)didSelectItemAtCellModel:(HVUICollectionViewCellModel *)cellModel{
    for (HVUICollectionViewCellModel *cellModel in self.model.allCellModels) {
        cellModel.selected = NO;
    }
    cellModel.selected = YES;
    [self reloadSegmentedViewData];
    [self reloadDataForCellTrack];
}
-(void)reloadDataForCellTrack{
    UICollectionViewCell *cell = self.model.selectedCellModel.collectionViewCell;
    [self.collectionView scrollToTrackOfPoint:cell];
    CGRect bounds = cell.bounds;
    CGRect f1 = cell.frame;
    [self.collectionView scrollToTrackOfPoint:cell];
    f1.size.height = 2;
    f1.origin.y =  bounds.size.height - f1.size.height;
    self.markView.frame = f1;
}
-(void)reloadSegmentedViewData{
    [self.model reloadCollectionViewData];
}
-(void)removeAllSections{
    [self.model removeAllSections];
}
+(CGFloat)controlHeight{
    return 40.f;//默认高度为40.f;
}
-(CGSize)sizeThatFits:(CGSize)size{
    CGFloat defaultHeight = [self.class controlHeight];
    CGSize sizeM = size;
    sizeM.height = defaultHeight;
    return sizeM;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    
    CGRect f1 = bounds;
    self.collectionView.frame = f1;
    [self reloadDataForCellTrack];
    [self reloadSegmentedViewData];
}
@end
