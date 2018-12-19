//
//  LWLabCarouselCollectionViewCell.m
//  lwlab
//
//  Created by 程恒盛 on 2018/5/2.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabCarouselCollectionViewCell.h"

@interface LWLabCarouselCollectionViewCell ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLabel;
@end
@implementation LWLabCarouselCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] init];
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.imageView];
        //
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.textColor = [UIColor colorWithWhite:0 alpha:0.7];
        self.titleLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds= self.contentView.bounds;
    CGRect f1 = bounds;
    self.imageView.frame = f1;
    //
    CGRect f2 = bounds;
    f2.size.height = 30.f;
    f2.origin.y = bounds.size.height - f2.size.height;
    self.titleLabel.frame = f2;
}
- (void)setCellModel:(LWLabSDWebImageModel *)cellModel{
    _cellModel = cellModel;
    [self.imageView setImageWithURL:[NSURL URLWithString:cellModel.thumbnail]];
    self.titleLabel.text = cellModel.title;
    [self setNeedsLayout];
}
@end
