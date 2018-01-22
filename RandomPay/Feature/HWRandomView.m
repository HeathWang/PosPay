//
//  HWRandomView.m
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWRandomView.h"

@interface HWRandomView ()

@property (nonatomic, strong) UILabel *lblRandom;

@property (nonatomic, strong) UITextField *fldMin;
@property (nonatomic, strong) UITextField *fldMax;

@property (nonatomic, strong) UIButton *btnStart;

@end

@implementation HWRandomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadViews];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self loadViews];
    }
    return self;
}

- (void)loadViews {
    [self addSubview:self.lblRandom];
    [self addSubview:self.fldMin];
    [self addSubview:self.fldMax];
    [self addSubview:self.btnStart];

    [self.lblRandom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(@0);
    }];

    [self.fldMin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.fldMax);
        make.left.equalTo(@18);
        make.right.equalTo(@-18);
        make.top.equalTo(self.lblRandom.mas_bottom).offset(5);
        make.height.mas_equalTo(44);
    }];

    [self.fldMax mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fldMin.mas_left);
        make.top.equalTo(self.fldMin.mas_bottom).offset(5);
    }];

    [self.btnStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.centerX.equalTo(@0);
        make.top.equalTo(self.fldMax.mas_bottom).offset(5);
    }];
}

#pragma mark - private method

- (UITextField *)createTextFieldWithTitle:(NSString *)title {
    UITextField *textField = [[UITextField alloc] init];
    textField.keyboardType = UIKeyboardTypeNumberPad;
    UILabel *label = [UILabel labelWithAlignment:NSTextAlignmentCenter textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:14] text:title];
    label.frame = CGRectMake(0, 0, 80, 30);
    textField.leftView = label;
    textField.leftViewMode = UITextFieldViewModeAlways;

    textField.layer.borderWidth = 1.5f;
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;

    return textField;
}

#pragma mark - Getter

- (UILabel *)lblRandom {
    if (!_lblRandom) {
        _lblRandom = [UILabel labelWithAlignment:NSTextAlignmentCenter textColor:[UIColor colorWithRed:0.377 green:0.920 blue:1.000 alpha:1.00] font:[UIFont systemFontOfSize:88 weight:UIFontWeightHeavy] text:@"0"];
    }
    return _lblRandom;
}

- (UITextField *)fldMin {
    if (!_fldMin) {
        _fldMin = [self createTextFieldWithTitle:@"Min"];
        _fldMin.placeholder = @"Please input Min Value";
    }
    return _fldMin;
}

- (UITextField *)fldMax {
    if (!_fldMax) {
        _fldMax = [self createTextFieldWithTitle:@"Max"];
        _fldMax.placeholder = @"Please input Max Value";
    }
    return _fldMax;
}

- (UIButton *)btnStart {
    if (!_btnStart) {
        _btnStart = [UIButton buttonWithFont:[UIFont systemFontOfSize:20 weight:UIFontWeightBold] title:@"Random" textColor:[UIColor whiteColor]];
        [_btnStart setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.377 green:0.920 blue:1.000 alpha:1.00]] forState:UIControlStateNormal];
        _btnStart.layer.masksToBounds = YES;
        _btnStart.layer.cornerRadius = 8;
    }
    return _btnStart;
}


@end
