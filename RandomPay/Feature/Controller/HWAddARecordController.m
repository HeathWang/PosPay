//
//  HWAddARecordController.m
//  RandomPay
//
//  Created by Heath on 22/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Realm/RLMRealm.h>
#import "HWAddARecordController.h"
#import "UITextField+Addition.h"
#import "HWRandom.h"
#import "MBProgressHUD+VBAdd.h"
#import "HWDatePickerView.h"
#import "DateTools.h"
#import "HWDaySectionHeader.h"
#import "HWTypeSelectCell.h"
#import "HWAppConfig.h"
#import "HWTypeSelectView.h"
#import "HWDayList.h"

@interface HWAddARecordController () <UITableViewDataSource, UITableViewDelegate, HWDatePickerViewDelegate, HWTypeSelectViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UITextField *fldAmount;
@property (nonatomic, strong) UILabel *lblDateSelect;

@property (nonatomic, strong) HWRandom *random;
@property (nonatomic, copy) NSDate *selectDate;

@property (nonatomic, assign) NSInteger indexWithCost;
@property (nonatomic, assign) NSInteger indexWithBank;
@property (nonatomic, assign) NSInteger indexWithPay;


@end

@implementation HWAddARecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupData];
    [self setupView];
    // Do any additional setup after loading the view.
}

- (void)setupNav {
    if (self.isEdit) {
        self.navigationItem.title = @"修改";
    } else {
        self.navigationItem.title = @"新增";
    }

    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(closeAction)];
    self.navigationItem.leftBarButtonItem = leftButton;
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(submitAction)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

- (void)setupData {

    if (self.isEdit) {
        self.random = [HWRandom objectForPrimaryKey:self.rid];
        if (self.random) {
            self.selectDate = self.random.randomDate;

            NSInteger index = [[HWAppConfig sharedInstance].posCostValueList indexOfObject:@(self.random.costPercent.floatValue)];
            if (index != NSNotFound) {
                self.indexWithCost = index;
            }

            self.fldAmount.text = [NSString stringWithFormat:@"%.1f", self.random.value.floatValue];

            self.indexWithBank = self.random.bankType.integerValue - 1;
            self.indexWithPay = self.random.posType.integerValue - 1;
        }
    } else {
        self.indexWithCost = 2;
        self.indexWithBank = 0;
        self.indexWithBank = 0;

        self.selectDate = [NSDate date];
    }
}

- (void)setupView {
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    self.lblDateSelect.text = [NSString stringWithFormat:@"日期：%@", [self.selectDate formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWTypeSelectCell *selectCell = [tableView dequeueReusableCellWithClass:HWTypeSelectCell.class forIndexPath:indexPath];
    selectCell.typeSelectView.delegate = self;

    switch (indexPath.section) {
        case 1:
            [selectCell updateCellList:[HWAppConfig sharedInstance].bankTypeList selectedIndex:self.indexWithBank];
            break;
        case 2:
            [selectCell updateCellList:[HWAppConfig sharedInstance].posTypeList selectedIndex:self.indexWithPay];
            break;
        default:
            [selectCell updateCellList:[HWAppConfig sharedInstance].posCostStrList selectedIndex:self.indexWithCost];
            break;
    }
    return selectCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = [HWTypeSelectCell calculateCellHeight:3];
    switch (indexPath.section) {
        case 0:
            height = [HWTypeSelectCell calculateCellHeight:[HWAppConfig sharedInstance].posCostStrList.count];
            break;
        case 1:
            height = [HWTypeSelectCell calculateCellHeight:[HWAppConfig sharedInstance].bankTypeList.count];
            break;
        case 2:
            height = [HWTypeSelectCell calculateCellHeight:[HWAppConfig sharedInstance].posTypeList.count];
            break;
        default:
            break;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 34;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HWDaySectionHeader *sectionHeader = [tableView dequeueReusableHeaderFooterViewWithClass:HWDaySectionHeader.class];
    switch (section) {
        case 1:
            sectionHeader.lblTitle.text = @"归属银行";
            break;
        case 2:
            sectionHeader.lblTitle.text = @"支付方式";
            break;
        default:
            sectionHeader.lblTitle.text = @"消费费率";
            break;
    }
    return sectionHeader;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


#pragma mark - HWDatePickerViewDelegate

- (void)didPicketDate:(NSDate *)pickedDate {
    self.selectDate = pickedDate;
    self.lblDateSelect.text = [NSString stringWithFormat:@"日期：%@", [self.selectDate formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]];
}

- (NSDate *)requireCurrentDate {
    return self.selectDate;
}

#pragma mark - HWTypeSelectViewDelegate

- (void)didSelectedAtIndex:(NSInteger)index inCell:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"%ld - %ld", indexPath.row, indexPath.section);
    switch (indexPath.section) {
        case 0:
        {
            self.indexWithCost = index;
        }
            break;
        case 1:
        {
            self.indexWithBank = index;
        }
            break;
        case 2:
        {
            self.indexWithPay = index;
        }
            break;
        default:
            break;
    }
}

#pragma mark - touch action

- (void)showDatePickerAction {
    [self.view endEditing:YES];
    [HWDatePickerView showInView:self.navigationController.view delegate:self];
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

        self.random.bankType = @(self.indexWithBank + 1);
        self.random.posType = @(self.indexWithPay + 1);
        self.random.costPercent = [HWAppConfig sharedInstance].posCostValueList[(NSUInteger) self.indexWithCost];
        self.random.randomDate = self.selectDate;
        self.random.value = @(self.fldAmount.text.floatValue);

        if ([previousDate isSameDay:self.selectDate]) {
            [realm addOrUpdateObject:self.random];
        } else {
            HWDayList *preDay = [HWDayList objectForPrimaryKey:previousDayId];
            NSInteger index = [preDay.randoms indexOfObjectWhere:@"rid = %@", self.random.rid];
            if (index != NSNotFound) {
                [preDay.randoms removeObjectAtIndex:(NSUInteger) index];

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
        random1.costPercent = [HWAppConfig sharedInstance].posCostValueList[(NSUInteger) self.indexWithCost];;
        random1.bankType = @(self.indexWithBank + 1);
        random1.posType = @(self.indexWithPay + 1);

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

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGFLOAT_MIN)];

        [_tableView registerHeaderFooterClass:HWDaySectionHeader.class];
        [_tableView registerClass:HWTypeSelectCell.class];

        _tableView.delegate = self;
        _tableView.dataSource = self;

    }
    return _tableView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [UIView new];
        _headerView.frame = CGRectMake(0, 0, ScreenWidth, 102);

        [_headerView addSubview:self.fldAmount];
        [_headerView addSubview:self.lblDateSelect];

        CGFloat bottomMargin = 10;
        [self.fldAmount mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(bottomMargin));
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
    }
    return _headerView;
}


- (UITextField *)fldAmount {
    if (!_fldAmount) {
        _fldAmount = [UITextField textFieldWithLeftTitle:@"金额：" keyboardType:UIKeyboardTypeDecimalPad];
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


@end
