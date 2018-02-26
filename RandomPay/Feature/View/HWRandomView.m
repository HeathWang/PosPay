//
//  HWRandomView.m
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWRandomView.h"
#import "MBProgressHUD+VBAdd.h"
#import "RLMRealm.h"
#import "HWRandom.h"
#import "NSUserDefaults+HWCache.h"
#import "HWDayList.h"
#import "DateTools.h"
#import "UITextField+Addition.h"

@interface HWRandomView ()

@property (nonatomic, strong) UILabel *lblRandom;

@property (nonatomic, strong) UITextField *fldMin;
@property (nonatomic, strong) UITextField *fldMax;

@property (nonatomic, strong) UIButton *btnStart;
@property (nonatomic, strong) UIButton *btnClean;

@property (nonatomic, strong) UILabel *lblIgnoreSingleDigits;
@property (nonatomic, strong) UISwitch *switchDigits;

@property (nonatomic, strong) UILabel *lblHasDecimals;
@property (nonatomic, strong) UISwitch *switchDecimals;

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

//- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier {
//    self = [super initWithReuseIdentifier:reuseIdentifier];
//    if (self) {
//        [self loadViews];
//    }
//    return self;
//}

- (void)loadViews {
    [self addSubview:self.lblRandom];
    [self addSubview:self.fldMin];
    [self addSubview:self.fldMax];

    NSArray *history = [NSUserDefaults getCacheRandomValues];
    if (history.count >= 2) {
        self.fldMin.text = history[0];
        self.fldMax.text = history[1];
    }

    [self addSubview:self.btnStart];

    [self addSubview:self.lblIgnoreSingleDigits];
    [self addSubview:self.switchDigits];

    [self addSubview:self.lblHasDecimals];
    [self addSubview:self.switchDecimals];

//    [self addSubview:self.btnClean];

    [self.lblRandom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.centerX.equalTo(@0);
    }];

    [self.fldMin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.fldMax);
        make.left.equalTo(@14);
        make.right.equalTo(@-18);
        make.top.equalTo(self.lblRandom.mas_bottom).offset(5);
        make.height.mas_equalTo(38);
    }];

    [self.fldMax mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fldMin.mas_left);
        make.top.equalTo(self.fldMin.mas_bottom).offset(5);
    }];

    [self.switchDigits mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fldMax.mas_bottom).offset(5);
        make.left.equalTo(self.lblIgnoreSingleDigits.mas_right).offset(12);
    }];

    [self.lblIgnoreSingleDigits mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.switchDigits);
        make.left.equalTo(@14);
    }];

    [self.switchDecimals mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.switchDigits);
        make.right.equalTo(@-14);
    }];

    [self.lblHasDecimals mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.switchDigits);
        make.right.equalTo(self.switchDecimals.mas_left).offset(-12);
    }];

    [self.btnStart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 44));
        make.centerX.equalTo(@0);
        make.top.equalTo(self.switchDigits.mas_bottom).offset(5);
    }];

//    [self.btnClean mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(60, 34));
//        make.right.equalTo(@-5);
//        make.bottom.equalTo(@-5);
//    }];
}

#pragma mark - touch action

- (void)randomAction {
    if (self.fldMin.text.integerValue <= 0) {
        [MBProgressHUD showNoBlockTip:@"请输入随机数最小数" toView:[UIApplication sharedApplication].keyWindow hideDelay:2];
        return;
    }

    if (self.fldMax.text.integerValue <= 0) {
        [MBProgressHUD showNoBlockTip:@"请输入随机数最大数" toView:[UIApplication sharedApplication].keyWindow hideDelay:2];
        return;
    }

    if (self.fldMax.text.integerValue <= self.fldMin.text.integerValue) {
        [MBProgressHUD showNoBlockTip:@"随机数最大数需大于最小数" toView:[UIApplication sharedApplication].keyWindow hideDelay:2];
        return;
    }

    [self endEditing:YES];
    [MBProgressHUD showHUDWithMessage:nil toView:[UIApplication sharedApplication].keyWindow];

    NSNumber *result = [HWRandom getUniqueRandomFrom:self.fldMin.text.integerValue to:self.fldMax.text.integerValue ignoreDigits:self.switchDigits.on hasDecimals:self.switchDecimals.on];

    RLMRealm *realm = [RLMRealm defaultRealm];
    NSDate *nowDate = [NSDate date];
    NSNumber *dayId = @([nowDate formattedDateWithFormat:@"yyyyMMdd"].integerValue);

    [realm beginWriteTransaction];

    // new random obj
    HWRandom *random = [HWRandom new];
    random.randomDate = nowDate;
    random.value = result;

    RLMResults *originDayResult = [HWDayList objectsWhere:@"dayId = %@", dayId];
    if (originDayResult.count > 0) {
        HWDayList *originDayList = originDayResult[0];
        [originDayList.randoms addObject:random];
        [realm addOrUpdateObject:originDayList];
    } else {
        HWDayList *dayList = [HWDayList new];
        dayList.dayId = dayId;
        dayList.dateStr = [nowDate formattedDateWithFormat:@"yyyy-MM-dd"];
        [dayList.randoms addObject:random];

        [realm addOrUpdateObject:dayList];
    }

    [realm commitWriteTransaction];

    [NSUserDefaults cacheMinRandomValue:self.fldMin.text maxValue:self.fldMax.text];
    if (self.switchDecimals.on) {
        self.lblRandom.text = [NSString stringWithFormat:@"%.1f", result.floatValue];
    } else {
        self.lblRandom.text = [NSString stringWithFormat:@"%ld", result.integerValue];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:NO];
    });

}

- (void)cleanAction {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObjects:[HWRandom allObjects]];
    [realm deleteObjects:[HWDayList allObjects]];
    [realm commitWriteTransaction];
}

#pragma mark - private method

- (UITextField *)createTextFieldWithTitle:(NSString *)title {
    UITextField *textField = [UITextField textFieldWithLeftTitle:title keyboardType:UIKeyboardTypeNumberPad];
    return textField;
}

#pragma mark - Getter

- (UILabel *)lblRandom {
    if (!_lblRandom) {
        _lblRandom = [UILabel labelWithAlignment:NSTextAlignmentCenter textColor:[UIColor colorWithRed:0.377 green:0.920 blue:1.000 alpha:1.00] font:[UIFont systemFontOfSize:44 weight:UIFontWeightLight] text:@"0"];
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

        [_btnStart addTarget:self action:@selector(randomAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnStart;
}

- (UIButton *)btnClean {
    if (!_btnClean) {
        _btnClean = [UIButton buttonWithFont:[UIFont systemFontOfSize:40] title:@"✖︎" textColor:[UIColor colorWithRed:0.377 green:0.920 blue:1.000 alpha:1.00]];
        [_btnClean addTarget:self action:@selector(cleanAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnClean;
}


- (UILabel *)lblIgnoreSingleDigits {
    if (!_lblIgnoreSingleDigits) {
        _lblIgnoreSingleDigits = [UILabel labelWithAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] text:@"忽略个位"];
    }
    return _lblIgnoreSingleDigits;
}

- (UISwitch *)switchDigits {
    if (!_switchDigits) {
        _switchDigits = [[UISwitch alloc] init];
    }
    return _switchDigits;
}

- (UILabel *)lblHasDecimals {
    if (!_lblHasDecimals) {
        _lblHasDecimals = [UILabel labelWithAlignment:NSTextAlignmentLeft textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] text:@"包含小数"];
    }
    return _lblHasDecimals;
}

- (UISwitch *)switchDecimals {
    if (!_switchDecimals) {
        _switchDecimals = [UISwitch new];
    }
    return _switchDecimals;
}


@end
