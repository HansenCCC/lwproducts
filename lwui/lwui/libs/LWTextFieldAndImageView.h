//
//  LWTextFieldAndImageView.h
//  CHHomeDec
//  附带icon的输入框
//  Created by 程恒盛 on 2018/8/19.
//  Copyright © 2018年 Herson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVUIFlowLayoutButton.h"

@interface LWTextFieldAndImageView : UIView
@property(strong,  readonly) UITextField *textField;
@property (strong, readonly) HVUIFlowLayoutButton *leftBtn;
@property (strong, readonly) HVUIFlowLayoutButton *rightBtn;

@property(strong, nonatomic) UIImage *leftImage;//leftImage
@property(strong, nonatomic) UIImage *rightImage;//rightImage

@property(nonatomic, assign) UIEdgeInsets contentInsets;//textfield内边距,默认为(0,0,0,0)
@end
