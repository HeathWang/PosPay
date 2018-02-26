//
//  HWAddRecordController.m
//  RandomPay
//
//  Created by Heath on 01/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWAddRecordController.h"
#import "UITextField+Addition.h"
#import "HWRandom.h"
#import "DateTools.h"
#import "HWDayList.h"
#import "HWTypeSelectView.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+VBAdd.h"
#import "HWAppConfig.h"

@interface HWAddRecordController ()

@property (nonatomic, strong) UITextField *fldAmount;
@property (nonatomic, strong) UILabel *lblDateSelect;
@property (nonatomic, strong) UILabel *lblCost;
@property (nonatomic, strong) UILabel *lblBank;
@property (nonatomic, strong) UILabel *lblPosType;

@property (nonatomic, strong) HWTypeSelectView *posCostSelectView;
@property (nonatomic, strong) HWTypeSelectView *bankSelectView;
@property (nonatomic, strong) HWTypeSelectView *posTypeSelectView;

// data
@property (nonatomic, strong) HWRandom *random;
@property (nonatomic, copy) NSDate *selectDate;

@end

@implementation HWAddRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupData];
    [self setupNav];
    [self setupView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupData {
    if (self.isEdit) {
        self.random = [HWRandom objectForPrimaryKey:self.rid];
        if (self.random) {
            self.selectDate = self.random.randomDate;

            NSInteger index = [[HWAppConfig sharedInstance].posCostValueList indexOfObject:@(self.random.costPercent.floatValue)];
            if (index != NSNotFound) {
                [self.posCostSelectView changeSelectIndex:index];
            }

            self.fldAmount.text = [NSString stringWithFormat:@"%.1f", self.random.value.floatValue];

            [self.bankSelectView changeSelectIndex:self.random.bankType.integerValue - 1];
            [self.posTypeSelectView changeSelectIndex:self.random.posType.integerValue - 1];
        }
    } else {
        self.selectDate = [NSDate date];

        // set default select.
        [self.posCostSelectView changeSelectIndex:2];

    }

}

- (void)setupNav {
    if (self.isEdit) {
        self.navigationItem.title = @"EDIT";
    } else {
        self.navigationItem.title = @"ADD";
    }

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeAction)];
    self.navigationItem.leftBarButtonItem = leftButton;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(submitAction)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)setupView {
    [self.view addSubview:self.fldAmount];
    [self.view addSubview:self.lblDateSelect];

    [self.view addSubview:self.lblCost];
    [self.view addSubview:self.posCostSelectView];

    [self.view addSubview:self.lblBank];
    [self.view addSubview:self.bankSelectView];

    [self.view addSubview:self.lblPosType];
    [self.view addSubview:self.posTypeSelectView];


    [self setupViewConstraints];

    [self updateUI];
}

- (void)setupViewConstraints {
    CGFloat bottomMargin = 6;
    [self.fldAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@84);
        make.left.equalTo(@14);
        make.right.equalTo(@-18);
        make.height.mas_equalTo(38);
    }];

    [self.lblDateSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
        make.top.equalTo(self.fldAmount.mas_bottom).offset(bottomMargin);
    }];

    UIButton *btnDate = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDate addTarget:self action:@selector(showDatePickerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.lblDateSelect addSubview:btnDate];
    [btnDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    [self.lblCost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.centerY.equalTo(self.posCostSelectView);
    }];

    [self.posCostSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblCost.mas_right).offset(5);
        make.right.equalTo(@0);
        make.top.equalTo(self.lblDateSelect.mas_bottom).offset(bottomMargin);
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

- (void)updateUI {
    self.lblDateSelect.text = [NSString stringWithFormat:@"日期：%@", [self.selectDate formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
}

#pragma mark - HWDatePickerViewDelegate

- (void)didPicketDate:(NSDate *)pickedDate {
    self.selectDate = pickedDate;
    [self updateUI];
}

- (NSDate *)requireCurrentDate {
    return self.selectDate;
}

#pragma mark - touch action

- (void)closeAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{

    }];
}

- (void)showDatePickerAction {
    [HWDatePickerView showInView:self.navigationController.view delegate:self];
}

- (void)submitAction {
    [self.view endEditing:YES];

    if (self.fldAmount.text.floatValue <= 0) {
        [MBProgressHUD showInfo:@"金额必须大于0" toView:self.view hideDelay:1.5];
        return;
    }

    RLMRealm *realm = [RLMRealm defaultRealm];

    NSDate *previousDate = [self.random.randomDate copy];
    NSNumber *previousDayId = @([previousDate formattedDateWithFormat:@"yyyyMMdd"].integerValue);

    NSNumber *dayId = @([self.selectDate formattedDateWithFormat:@"yyyyMMdd"].integerValue);

    if (self.isEdit) {
        [realm beginWriteTransaction];

        self.random.bankType = @(self.bankSelectView.selectIndex + 1);
        self.random.posType = @(self.posTypeSelectView.selectIndex + 1);
        self.random.costPercent = [HWAppConfig sharedInstance].posCostValueList[(NSUInteger) self.posCostSelectView.selectIndex];
        self.random.randomDate = self.selectDate;
        self.random.value = @(self.fldAmount.text.floatValue);

        if ([previousDate isSameDay:self.selectDate]) {
            [realm addOrUpdateObject:self.random];
        } else {
            HWDayList *preDay = [HWDayList objectForPrimaryKey:previousDayId];
            NSInteger index = [preDay.randoms indexOfObjectWhere:@"rid = %@", self.random.rid];
            if (index != NSNotFound) {
                [preDay.randoms removeObjectAtIndex:index];

                if (preDay.randoms.count <= 0) {
                    [realm deleteObject:preDay];
                } else {
                    [realm addOrUpdateObject:preDay];
                }

            }

            RLMResults *originDayResult = [HWDayList objectsWhere:@"dayId = %@", dayId];
            if (originDayResult.count > 0) {
                HWDayList *originDayList = originDayResult[0];
                [originDayList.randoms addObject:self.random];
                [realm addOrUpdateObject:originDayList];
            } else {
                HWDayList *dayList = [HWDayList new];
                dayList.dayId = dayId;
                dayList.dateStr = [self.selectDate formattedDateWithFormat:@"yyyy-MM-dd"];
                [dayList.randoms addObject:self.random];

                [realm addOrUpdateObject:dayList];
            }
        }

        [realm commitWriteTransaction];

        [self closeAction];
    } else {

        HWRandom *random1 = [HWRandom new];
        random1.randomDate = self.selectDate;
        random1.value = @(self.fldAmount.text.floatValue);
        random1.costPercent = [HWAppConfig sharedInstance].posCostValueList[(NSUInteger) self.posCostSelectView.selectIndex];;
        random1.bankType = @(self.bankSelectView.selectIndex + 1);
        random1.posType = @(self.posTypeSelectView.selectIndex + 1);

        [realm beginWriteTransaction];

        RLMResults *originDayResult = [HWDayList objectsWhere:@"dayId = %@", dayId];
        if (originDayResult.count > 0) {
            HWDayList *originDayList = originDayResult[0];
            [originDayList.randoms addObject:random1];
            [realm addOrUpdateObject:originDayList];
        } else {
            HWDayList *dayList = [HWDayList new];
            dayList.dayId = dayId;
            dayList.dateStr = [self.selectDate formattedDateWithFormat:@"yyyy-MM-dd"];
            [dayList.randoms addObject:random1];

            [realm addOrUpdateObject:dayList];
        }

        [realm commitWriteTransaction:NULL];
        [self closeAction];
    }
}


#pragma mark - Getter

- (UITextField *)fldAmount {
    if (!_fldAmount) {
        _fldAmount = [UITextField textFieldWithLeftTitle:@"Amount" keyboardType:UIKeyboardTypeDecimalPad];
        _fldAmount.placeholder = @"请输入金额";
    }
    return _fldAmount;
}

- (UILabel *)lblDateSelect {
    if (!_lblDateSelect) {
        _lblDateSelect = [UILabel labelWithAlignment:NSTextAlignmentLeft textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16] text:@"日期："];
        _lblDateSelect.userInteractionEnabled = YES;
    }
    return _lblDateSelect;
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
        _posCostSelectView = [[HWTypeSelectView alloc] initWithTypeList:[HWAppConfig sharedInstance].posCostStrList];
    }
    return _posCostSelectView;
}

- (HWTypeSelectView *)bankSelectView {
    if (!_bankSelectView) {
        _bankSelectView = [[HWTypeSelectView alloc] initWithTypeList:[HWAppConfig sharedInstance].bankTypeList];
    }
    return _bankSelectView;
}

- (HWTypeSelectView *)posTypeSelectView {
    if (!_posTypeSelectView) {
        _posTypeSelectView = [[HWTypeSelectView alloc] initWithTypeList:[HWAppConfig sharedInstance].posTypeList];
    }
    return _posTypeSelectView;
}


@end
