//
//  LWFormSelectColorViewCell.h
//  lwui
//  颜色选择
//  Created by 程恒盛 on 2018/4/23.
//  Copyright © 2018年 力王. All rights reserved.
//

#import "LWFormSelectOneViewCell.h"
#import "LWFormSelectOption.h"
@interface LWFormSelectColorViewCell : LWFormSelectOneViewCell

@end

/**
 pickerView Cell
 */
@interface LWUIColorPickerViewCellView  :UIView
@property (readonly, nonatomic) UIView *colorView;
@property (readonly, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) LWFormSelectOption *option;
@property(nonatomic,strong) UIColor *selectedColor;
@end
