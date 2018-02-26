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

@interface HWQueryOptionsView ()

@property (nonatomic, strong) UILabel *lblStartDate;
@property (nonatomic, strong) UILabel *lblEndDate;
@property (nonatomic, strong) UIButton *btnStart;
@property (nonatomic, strong) UIButton *btnEnd;

@property (nonatomic, strong) UILabel *lblCost;
@property (nonatomic, strong) UILabel *lblBank;
@property (nonatomic, strong) UILabel *lblPosType;

@property (nonatomic, strong) HWTypeSelectView *posCostSelectView;
@property (nonatomic, strong) HWTypeSelectView *bankSelectView;
@property (nonatomic, strong) HWTypeSelectView *posTypeSelectView;

@end

@implementation HWQueryOptionsView


#pragma mark - Getter

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

@end
