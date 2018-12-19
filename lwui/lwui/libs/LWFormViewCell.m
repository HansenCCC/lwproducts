//
//  LWFormViewCell.m
//  lwlab
//
//  Created by 程恒盛 on 2018/3/16.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWFormViewCell.h"

@interface LWFormViewCell ()
@property(strong, nonatomic) HVUIFlowLayoutButton *commonButton;

@end

@implementation LWFormViewCell
DEF_SINGLETON(LWFormViewCell);
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
        //
        self.commonButton = [[HVUIFlowLayoutButton alloc] init];
        self.commonButton.userInteractionEnabled = NO;
        self.commonButton.interitemSpacing = 15.f;
        self.commonButton.titleLabel.font = [UIFont systemFontOfSize:17];
        self.commonButton.imageSize = CGSizeMake(30.f, 30.f);
        [self.commonButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.contentView addSubview:self.commonButton];
        //
        self.flowLayoutConstraint = [[HVUIFlowLayoutConstraint alloc] initWithItems:@[self.commonButton] constraintParam:HVUIFlowLayoutConstraintParam_H_C_L contentInsets:[self.class contentMarginInsets] interitemSpacing:15];
    }
    return self;
}
+ (UIEdgeInsets)contentMarginInsets{
    return kLWFormViewCellMargin;
}
- (UIEdgeInsets)contentMarginInsets{
    return [self.class contentMarginInsets];
}
#pragma mark- model
DEF_HVTableViewCellModel(LWFormElement, customCellModel);
- (void)setCustomCellModel:(LWFormElement *)customCellModel{
    _customCellModel = customCellModel;
    [self.commonButton setTitle:customCellModel.title forState:UIControlStateNormal];
    [self.commonButton setImage:customCellModel.icon forState:UIControlStateNormal];
    //
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
#pragma mark- layout
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    self.flowLayoutConstraint.bounds = bounds;
    self.flowLayoutConstraint.contentInsets = self.contentMarginInsets;
    [self.flowLayoutConstraint layoutItemsWithResizeItems:YES];
}
+(CGFloat)heightWithTableView:(UITableView *)tableView cellModel:(HVTableViewCellModel *)cellModel{
    return kLWFormViewCellDefaultHeight;
}
@end
