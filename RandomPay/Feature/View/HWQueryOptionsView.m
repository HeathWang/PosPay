//
//  HWQueryOptionsView.m
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWQueryOptionsView.h"
#import "HWTypeSelectView.h"
#import "HWAppConfig.h"
#import "DateTools.h"

@interface HWQueryOptionsView ()

@property (nonatomic, strong) UILabel *lblStartDate;
@property (nonatomic, strong) UILabel *lblEndDate;

@property (nonatomic, strong) UILabel *lblCost;
@property (nonatomic, strong) UILabel *lblBank;
@property (nonatomic, strong) UILabel *lblPosType;

@property (nonatomic, strong) HWTypeSelectView *posCostSelectView;
@property (nonatomic, strong) HWTypeSelectView *bankSelectView;
@property (nonatomic, strong) HWTypeSelectView *posTypeSelectView;

@end

@implementation HWQueryOptionsView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        [self addSubview:self.lblStartDate];
        [self addSubview:self.lblEndDate];

        [self addSubview:self.lblCost];
        [self addSubview:self.posCostSelectView];

        [self addSubview:self.lblBank];
        [self addSubview:self.bankSelectView];

        [self addSubview:self.lblPosType];
        [self addSubview:self.posTypeSelectView];

        [self setupViewConstraints];

    }
    return self;
}

- (void)setupViewConstraints {

    CGFloat bottomMargin = 6;

    [self.lblStartDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.equalTo(@10);
    }];

    [self.lblEndDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.equalTo(self.lblStartDate.mas_bottom).offset(bottomMargin);
    }];

    [self.lblCost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.centerY.equalTo(self.posCostSelectView);
    }];

    [self.posCostSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblCost.mas_right).offset(5);
        make.right.equalTo(@0);
        make.top.equalTo(self.lblEndDate.mas_bottom).offset(bottomMargin);
        make.height.mas_equalTo(44);
    }];

    [self.lblBank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bankSelectView);
        make.left.equalTo(@14);
    }];

    [self.bankSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblBank.mas_right).offset(5);
        make.right.equalTo(@0);
        make.top.equalTo(self.posCostSelectView.mas_bottom).offset(bottomMargin);
        make.height.mas_equalTo(44);
    }];

    [self.lblPosType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.posTypeSelectView);
        make.left.equalTo(@14);
    }];

    [self.posTypeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblPosType.mas_right).offset(5);
        make.right.equalTo(@0);
        make.top.equalTo(self.bankSelectView.mas_bottom).offset(bottomMargin);
        make.height.mas_equalTo(44);
    }];
}

- (void)updateSelectDate {
    self.lblStartDate.text = [NSString stringWithFormat:@"开始日期：%@", [self.startDate formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
    self.lblEndDate.text = [NSString stringWithFormat:@"结束日期：%@", [self.endDate formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
}

#pragma mark - Getter

- (UILabel *)lblStartDate {
    if (!_lblStartDate) {
        _lblStartDate = [UILabel labelWithAlignment:NSTextAlignmentLeft textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16] text:@"开始日期："];
        _lblStartDate.userInteractionEnabled = YES;
    }
    return _lblStartDate;
}

- (UILabel *)lblEndDate {
    if (!_lblEndDate) {
        _lblEndDate = [UILabel labelWithAlignment:NSTextAlignmentLeft textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16] text:@"结束日期："];
        _lblEndDate.userInteractionEnabled = YES;
    }
    return _lblEndDate;
}


- (UILabel *)lblCost {
    if (!_lblCost) {
        _lblCost = [UILabel labelWithAlignment:NSTextAlignmentLeft textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16] text:@"费率："];
    }
    return _lblCost;
}

- (UILabel *)lblBank {
    if (!_lblBank) {
        _lblBank = [UILabel labelWithAlignment:NSTextAlignmentLeft textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16] text:@"银行："];
    }
    return _lblBank;
}

- (UILabel *)lblPosType {
    if (!_lblPosType) {
        _lblPosType = [UILabel labelWithAlignment:NSTextAlignmentLeft textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16] text:@"支付："];
    }
    return _lblPosType;
}

- (HWTypeSelectView *)posCostSelectView {
    if (!_posCostSelectView) {
        NSMutableArray *list = [[HWAppConfig sharedInstance].posCostStrList mutableCopy];
        [list insertObject:@"全部" atIndex:0];
        _posCostSelectView = [[HWTypeSelectView alloc] initWithTypeList:list];
    }
    return _posCostSelectView;
}

- (HWTypeSelectView *)bankSelectView {
    if (!_bankSelectView) {
        NSMutableArray *list = [[HWAppConfig sharedInstance].bankTypeList mutableCopy];
        [list insertObject:@"全部" atIndex:0];
        _bankSelectView = [[HWTypeSelectView alloc] initWithTypeList:list];
    }
    return _bankSelectView;
}

- (HWTypeSelectView *)posTypeSelectView {
    if (!_posTypeSelectView) {
        NSMutableArray *list = [[HWAppConfig sharedInstance].posTypeList mutableCopy];
        [list insertObject:@"全部" atIndex:0];
        _posTypeSelectView = [[HWTypeSelectView alloc] initWithTypeList:list];
    }
    return _posTypeSelectView;
}

- (NSInteger)filterCostPercent {
    return self.posCostSelectView.selectIndex;
}

- (NSInteger)filterBank {
    return self.bankSelectView.selectIndex;
}

- (NSInteger)filterPosType {
    return self.posTypeSelectView.selectIndex;
}


@end
