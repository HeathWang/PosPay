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

@interface HWAddRecordController () <UIActionSheetDelegate>

@property (nonatomic, strong) UITextField *fldAmount;
@property (nonatomic, strong) UILabel *lblDateSelect;
@property (nonatomic, strong) UILabel *lblCost;
@property (nonatomic, strong) UISlider *sliderCost;
@property (nonatomic, strong) UILabel *lblBank;
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) HWTypeSelectView *posCostSelectView;

// data
@property (nonatomic, strong) HWRandom *random;
@property (nonatomic, copy) NSDate *selectDate;
@property (nonatomic, copy) NSNumber *typeNumber;
@property (nonatomic, copy) NSArray *bankList;

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
            self.typeNumber = @(self.random.bankType.integerValue - 1);
            self.sliderCost.value = self.random.costPercent.floatValue * 100;
            self.fldAmount.text = [NSString stringWithFormat:@"%.1f", self.random.value.floatValue];
        }
    } else {
        self.selectDate = [NSDate date];
        self.typeNumber = @(0);
    }

    self.bankList = @[@"中信", @"招商", @"浦发"];
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
    [self.view addSubview:self.datePicker];

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

    [self.lblCost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.centerY.equalTo(self.posCostSelectView);
    }];

    [self.posCostSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.lblCost.mas_right).offset(5);
        make.right.equalTo(@-14);
        make.top.equalTo(self.lblDateSelect.mas_bottom).offset(bottomMargin);
        make.height.mas_equalTo(44);
    }];

    [self.lblBank mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.posCostSelectView.mas_bottom).offset(bottomMargin);
        make.left.equalTo(@14);
        make.right.equalTo(@-14);
    }];

    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
    }];

    UIButton *button = [UIButton new];
    [button addTarget:self action:@selector(showSelectBank) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.lblBank);
    }];
}

- (void)updateUI {
    self.lblDateSelect.text = [NSString stringWithFormat:@"日期：%@", [self.selectDate formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
    self.lblBank.text = [NSString stringWithFormat:@"银行类型：%@", self.bankList[(NSUInteger) self.typeNumber.integerValue]];
    self.datePicker.date = self.selectDate;
}

#pragma mark - touch action

- (void)sliderValueChanged:(UISlider *)sender {
    [self updateUI];
}

- (void)datePickerDateChanged:(UIDatePicker *)sender {
    self.selectDate = sender.date;
    [self updateUI];
}

- (void)showSelectBank {
    [self.view endEditing:YES];
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择银行" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"中信", @"招商", @"浦发", nil];
    [sheet showInView:self.navigationController.view];
}


- (void)closeAction {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{

    }];
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

        self.random.bankType = @(self.typeNumber.integerValue + 1);
        self.random.costPercent = @(self.sliderCost.value / 100.00f);
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
        random1.costPercent = @(self.sliderCost.value / 100.00f);
        random1.bankType = @(self.typeNumber.integerValue + 1);

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

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 3)
        return;

    self.typeNumber = @(buttonIndex);
    [self updateUI];
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
        _lblBank = [UILabel labelWithAlignment:NSTextAlignmentLeft textColor:[UIColor darkGrayColor] font:[UIFont systemFontOfSize:16] text:@"银行类型："];
    }
    return _lblBank;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        _datePicker.minimumDate = [[NSDate date] dateByAddingYears:-1];
        _datePicker.maximumDate = [[NSDate date] dateByAddingMonths:1];

        [_datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;
}


- (HWTypeSelectView *)posCostSelectView {
    if (!_posCostSelectView) {
        _posCostSelectView = [[HWTypeSelectView alloc] initWithTypeList:@[@"0.00", @"0.38", @"0.60", @"1.00"]];
    }
    return _posCostSelectView;
}


@end
