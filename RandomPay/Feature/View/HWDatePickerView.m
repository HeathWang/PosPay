//
//  HWDatePickerView.m
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWDatePickerView.h"
#import "DateTools.h"

@interface HWDatePickerView ()

@property (nonatomic, strong) UIView *contentView;

@property (nonatomic, strong) UIButton *btnClose;
@property (nonatomic, strong) UIButton *btnDone;
@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation HWDatePickerView

+ (void)showInView:(UIView *)view delegate:(id<HWDatePickerViewDelegate>)delegate {
    HWDatePickerView *pickerView = [[HWDatePickerView alloc] initWithFrame:view.bounds];
    pickerView.delegate = delegate;
    [view addSubview:pickerView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            pickerView.alpha = 1;
            [pickerView.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(pickerView.mas_bottom).offset(-pickerView.contentView.bounds.size.height);
            }];

            [pickerView layoutIfNeeded];
        } completion:^(BOOL finished) {

        }];
    });
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        self.alpha = 0.3;

        [self addSubview:self.contentView];
        [self.contentView addSubview:self.btnClose];
        [self.contentView addSubview:self.btnDone];
        [self.contentView addSubview:self.datePicker];

        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.mas_bottom);
        }];

        [self.btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 38));
            make.left.top.equalTo(@0);
        }];

        [self.btnDone mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 38));
            make.right.top.equalTo(@0);
        }];

        [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.top.equalTo(self.btnClose.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    return self;
}

- (void)willMoveToSuperview:(nullable UIView *)newSuperview {
    if (newSuperview) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requireCurrentDate)]) {
            NSDate *date = [self.delegate requireCurrentDate];
            self.datePicker.date = date;
        }
    }
}

#pragma mark - touch action

- (void)cancelAction {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0.5;
        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom).offset(20);
        }];

        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)doneAction {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPicketDate:)]) {
        [self.delegate didPicketDate:self.datePicker.date];
    }

    [self cancelAction];
}

#pragma mark - Getter

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}


- (UIButton *)btnClose {
    if (!_btnClose) {
        _btnClose = [UIButton buttonWithFont:[UIFont systemFontOfSize:14] title:@"取消" textColor:kThemeColor];
        [_btnClose addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnClose;
}

- (UIButton *)btnDone {
    if (!_btnDone) {
        _btnDone = [UIButton buttonWithFont:[UIFont systemFontOfSize:14] title:@"确定" textColor:kThemeColor];
        [_btnDone addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDone;
}


- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.minimumDate = [[NSDate date] dateByAddingYears:-2];
        _datePicker.maximumDate = [[NSDate date] dateByAddingMonths:1];

//        [_datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}


@end
