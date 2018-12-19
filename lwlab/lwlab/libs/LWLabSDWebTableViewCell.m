//
//  LWLabSDWebTableViewCell.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/30.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabSDWebTableViewCell.h"

@interface LWLabSDWebTableViewCell ()
@property(strong, nonatomic) UILabel *titleLabel;
@property(strong, nonatomic) UIImageView *urlImageView;
@end

@implementation LWLabSDWebTableViewCell
DEF_SINGLETON(LWLabSDWebTableViewCell);
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
        //
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        //
        self.urlImageView = [[UIImageView alloc] init];
        self.urlImageView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.urlImageView];
    }
    return self;
}
#pragma mark- model
DEF_HVTableViewCellModel(LWLabSDWebTableViewCellModel, customCellModel);
- (void)setCustomCellModel:(LWLabSDWebTableViewCellModel *)customCellModel{
    _customCellModel = customCellModel;
    self.titleLabel.text = customCellModel.title;
    @HV_WEAKIFY(self);
    self.urlImageView.image = nil;
    if (customCellModel.urlString.length != 0) {
        [self.urlImageView setImageWithURL:[NSURL URLWithString:customCellModel.urlString]];
        UIImage *image = self.urlImageView.image;
        if (image) {
            
        }else{
            [self.urlImageView setImageWithURL:[NSURL URLWithString:customCellModel.urlString] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, NSURL * _Nullable imageURL) {
                @HV_NORMALIZEANDNOTNIL(self);
                [self.cellModel refresh];
            }];
        }
    }
    //
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
#pragma mark- layout
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    CGRect f1 = bounds;
    CGFloat space = 20.f;
    f1.size = [self.titleLabel sizeThatFits:CGSizeMake(bounds.size.width - 2*space, 0)];
    f1.origin.x = space;
    f1.origin.y = space;
    self.titleLabel.frame = f1;
    //
    CGRect f2 = bounds;
    f2.origin.x = f1.origin.x;
    f2.origin.y = CGRectGetMaxY(f1) + f1.origin.x;
    f2.size = [self.urlImageView sizeThatFitsToMaxSize:CGSizeMake(bounds.size.width - 2*space, 0)];
    self.urlImageView.frame = f2;
}
+(CGFloat)heightWithTableView:(UITableView *)tableView cellModel:(HVTableViewCellModel *)cellModel{
    CGFloat height = [LWLabSDWebTableViewCell dynamicHeightWithTableView:tableView cellModel:cellModel cellShareInstance:[self.class sharedInstance] calBlock:^CGFloat(UITableView *tableView, HVTableViewCellModel *cellModel, id cell) {
        LWLabSDWebTableViewCell *_cell = cell;
        CGFloat height = CGRectGetMaxY(_cell.urlImageView.frame) + 20.f;
        return height;
    }];
    return height;
}
@end
