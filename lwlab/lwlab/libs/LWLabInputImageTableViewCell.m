//
//  LWLabInputImageTableViewCell.m
//  lwlab
//
//  Created by 程恒盛 on 2018/4/18.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import "LWLabInputImageTableViewCell.h"

@interface LWLabInputImageTableViewCell ()
@property(strong, nonatomic) LWUITextView *textView;
@property(strong, nonatomic) HVUIFlowLayoutButton *iconButton;

@end

@implementation LWLabInputImageTableViewCell
DEF_SINGLETON(LWLabInputImageTableViewCell);
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.separatorInset = UIEdgeInsetsMake(0, 8, 0, 8);
        //
        self.textView = [[LWUITextView alloc] init];
        self.textView.userInteractionEnabled = NO;
        self.textView.font = [UIFont systemFontOfSize:13];
        self.textView.placeholder = @"选择图标文件：";
        @HV_WEAKIFY(self);
        self.textView.whenContentHeightChange = ^(LWUITextView *textView, CGFloat newHeight) {
            @HV_NORMALIZEANDNOTNIL(self);
            self.customCellModel.filePath = textView.text;
            [self.customCellModel refresh];
        };
        [self.contentView addSubview:self.textView];
        //
        self.iconButton = [[HVUIFlowLayoutButton alloc] init];
        self.iconButton.imageSize = CGSizeMake(45.f, 45.f);
        self.iconButton.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.iconButton];
    }
    return self;
}
#pragma mark- model
DEF_HVTableViewCellModel(LWLabInputImageTableViewCellModel, customCellModel);
- (void)setCustomCellModel:(LWLabInputImageTableViewCellModel *)customCellModel{
    _customCellModel = customCellModel;
    self.textView.text = customCellModel.filePath;
    UIImage *image = customCellModel.iconImage;
    [self.iconButton setImage:image forState:UIControlStateNormal];
    //
    @HV_WEAKIFY(self);
    customCellModel.whenClick = ^(__kindof HVTableViewCellModel *cellModel) {
        @HV_NORMALIZEANDNOTNIL(self);
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"输入本地路径" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            LWLabInputImageTableViewCellModel *customCellModel = (LWLabInputImageTableViewCellModel *)cellModel;
            textField.text = customCellModel.filePath;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *textField = alert.textFields.firstObject;
            LWLabInputImageTableViewCellModel *customCellModel = (LWLabInputImageTableViewCellModel *)cellModel;
            customCellModel.filePath = textField.text;
            customCellModel.iconImage = nil;
            [customCellModel refreshWithAnimated:YES];
        }]];
        [self.topViewController presentViewController:alert animated:YES completion:nil];
    };
    [self setNeedsLayout];
}
#pragma mark- layout
- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect bounds = self.contentView.bounds;
    UIEdgeInsets insets = UIEdgeInsetsZero;
    insets.left = 20.f;
    insets.right = insets.left;
    //
    CGRect f1 = bounds;
    f1.size = [self.iconButton sizeThatFits:CGSizeZero];
    f1.origin.y = (bounds.size.height - f1.size.height)/2;
    f1.origin.x = bounds.size.width - f1.size.width - insets.right;
    self.iconButton.frame = f1;
    //
    CGRect f2 = bounds;
    CGSize f2_size = CGSizeZero;
    f2_size.width = bounds.size.width - insets.left - 2*insets.right - f1.size.width;
    f2.size = [self.textView sizeThatFits:f2_size];
    f2.size.width = f2_size.width;
    f2.origin.x = insets.left;
    f2.origin.y = (bounds.size.height - f2.size.height)/2;
    self.textView.frame = f2;
}
+(CGFloat)heightWithTableView:(UITableView *)tableView cellModel:(HVTableViewCellModel *)cellModel{
    CGFloat height = [LWLabInputImageTableViewCell dynamicHeightWithTableView:tableView cellModel:cellModel cellShareInstance:[self.class sharedInstance] calBlock:^CGFloat(UITableView *tableView, HVTableViewCellModel *cellModel, id cell) {
        LWLabInputImageTableViewCell *_cell = cell;
        CGFloat cellHeight = _cell.textView.frame.size.height + 30.f;
        return MAX(65.f, cellHeight);
    }];
    return height;
}
@end
