//
//  UITextField+Addition.m
//  RandomPay
//
//  Created by Heath on 01/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "UITextField+Addition.h"

@implementation UITextField (Addition)

+ (instancetype)textFieldWithLeftTitle:(NSString *)leftTitle keyboardType:(UIKeyboardType)keyboardType {
    UITextField *textField = [[UITextField alloc] init];
    textField.keyboardType = keyboardType;
    UILabel *label = [UILabel labelWithAlignment:NSTextAlignmentCenter textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14] text:leftTitle];
    label.frame = CGRectMake(0, 0, 80, 30);
    textField.leftView = label;
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.clearButtonMode = UITextFieldViewModeAlways;

    textField.layer.borderWidth = 1.5f;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;

    return textField;
}

@end
