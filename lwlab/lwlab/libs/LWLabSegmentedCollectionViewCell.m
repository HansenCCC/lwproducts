//
//  LWLabSegmentedCollectionViewCell.m
//  lwlab
//
//  Created by 程恒盛 on 2018/5/2.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabSegmentedCollectionViewCell.h"

@interface LWLabSegmentedCollectionViewCell ()
@property (strong, nonatomic) HVUIFlowLayoutButton *itemButton;
@property (strong, nonatomic) UIView *markView;
@end

@implementation LWLabSegmentedCollectionViewCell
DEF_SINGLETON(LWLabSegmentedCollectionViewCell);
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.itemButton = [[HVUIFlowLayoutButton alloc] init];
        self.itemButton.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [self.itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.itemButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        self.itemButton.userInteractionEnabled = NO;
        [self.contentView addSubview:self.itemButton];
        //
        self.markView = [[UIView alloc] init];
        self.markView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.markView];
    }
    return self;
}
- (void)setCollectionCellModel:(HVUICollectionViewCellModel *)collectionCellModel{
    self.segmentedmodel = (LWLabSegmentedCollectionViewCellModel *)collectionCellModel;
}
-(void)setSegmentedmodel:(LWLabSegmentedCollectionViewCellModel *)segmentedmodel{
    _segmentedmodel = segmentedmodel;
    [self.itemButton setTitle:segmentedmodel.title forState:UIControlStateNormal];
    self.itemButton.selected = segmentedmodel.selected;
    self.markView.hidden = !segmentedmodel.selected;
    [self setNeedsLayout];
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    f1.size = [self.itemButton sizeThatFits:CGSizeZero];
    f1.size.height = bounds.size.height;
    f1.origin.y = (bounds.size.height - f1.size.height)/2;
    f1.origin.x = 5.f;
    self.itemButton.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size.height = 2.f;
    f2.size.width = f1.size.width - 10.f;
    f2.origin.y = bounds.size.height - f2.size.height;
    f2.origin.x = (bounds.size.width - f2.size.width)/2;
    self.markView.frame = f2;
}
+ (CGSize)sizeWithCollectionView:(UICollectionView *)collectionView collectionCellModel:(HVUICollectionViewCellModel *)collectionCellModel{
    CGSize size = [self dynamicSizeWithCollectionView:collectionView collectionCellModel:collectionCellModel cellShareInstance:[self sharedInstance] calBlock:^CGSize(UICollectionView *collectionView, HVUICollectionViewCellModel *cellModel, id cell) {
        LWLabSegmentedCollectionViewCell *c = cell;
        CGSize _size = collectionView.bounds.size;
        _size.width = CGRectGetMaxX(c.itemButton.frame) + 5.f;
        return _size;
    }];
    return size;
}
@end
