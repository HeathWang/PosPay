//
//  HWSummaryController.m
//  RandomPay
//
//  Created by Heath on 01/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWSummaryController.h"
#import "RLMRealm.h"
#import "HWRandom.h"
#import <PNChart.h>
#import "HWHalfYearSummaryCell.h"
#import "DateTools.h"
#import "HWSummaryMonthModel.h"
#import "HWDateRangeModel.h"
#import "HWMonthDataListController.h"
#import "HWAppConfig.h"
#import "MBProgressHUD.h"
#import "MBProgressHUD+VBAdd.h"

@interface HWSummaryController () <UITableViewDataSource, UITableViewDelegate, HalfYearSummaryCellDelegate>

// data
@property (nonatomic, copy) NSNumber *total;
@property (nonatomic, copy) NSNumber *cost;

@property (nonatomic, copy) NSNumber *zxTotal;
@property (nonatomic, copy) NSNumber *zsTotal;
@property (nonatomic, copy) NSNumber *pfTotal;

@property (nonatomic, strong) NSMutableArray *barDataSource;
@property (nonatomic, copy) NSArray<HWDateRangeModel *> *dateRangeList;

// ui
@property (nonatomic, strong) UILabel *lblTotal;
@property (nonatomic, strong) UILabel *lblCost;

@property (nonatomic, strong) PNPieChart *pieChart;

@property (nonatomic, strong) UIView *tableHeader;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HWSummaryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"SUMMARY";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadUI)];
    self.navigationItem.rightBarButtonItem = rightItem;
    [self setupView];
    [self setupData];
}

- (void)setupView {
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeader;

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    [self.tableHeader addSubview:self.lblTotal];
    [self.tableHeader addSubview:self.lblCost];
    [self.tableHeader addSubview:self.pieChart];

    [self.lblTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(@20);
    }];

    [self.lblCost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(self.lblTotal.mas_bottom).offset(5);
    }];

    [self.pieChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.pieChart.frame.size);
        make.centerX.equalTo(@0);
        make.top.equalTo(self.lblCost.mas_bottom).offset(10);
    }];

}

- (void)setupData {

    [MBProgressHUD showHUDWithMessage:@"" toView:self.navigationController.view];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{

        // 查询汇总信息
        self.total = [[HWRandom allObjects] sumOfProperty:@"value"];
        NSNumber *total_38 = [[HWRandom objectsWhere:@"costPercent == 0.0038"] sumOfProperty:@"value"];
        NSNumber *total_60 = [[HWRandom objectsWhere:@"costPercent == 0.0060"] sumOfProperty:@"value"];
        NSNumber *total_100 = [[HWRandom objectsWhere:@"costPercent == 0.0100"] sumOfProperty:@"value"];
        self.cost = @(total_38.floatValue * 0.0038 + total_60.floatValue * 0.0060 + total_100.floatValue * 0.0100);

        self.zxTotal = [[HWRandom objectsWhere:@"bankType == 1"] sumOfProperty:@"value"];
        self.zsTotal = [[HWRandom objectsWhere:@"bankType == 2"] sumOfProperty:@"value"];
        self.pfTotal = [[HWRandom objectsWhere:@"bankType == 3"] sumOfProperty:@"value"];

        NSMutableArray *items = [NSMutableArray array];
        if (self.zxTotal.floatValue > 0) {
            [items addObject:[PNPieChartDataItem dataItemWithValue:self.zxTotal.floatValue color:[UIColor colorWithRed:0.831 green:0.039 blue:0.114 alpha:1.00] description:@"中信"]];
        }
        if (self.zsTotal.floatValue > 0) {
            [items addObject:[PNPieChartDataItem dataItemWithValue:self.zsTotal.floatValue color:[UIColor colorWithRed:0.675 green:0.169 blue:0.224 alpha:1.00] description:@"招商"]];
        }
        if (self.pfTotal.floatValue > 0) {
            [items addObject:[PNPieChartDataItem dataItemWithValue:self.pfTotal.floatValue color:[UIColor colorWithRed:0.016 green:0.212 blue:0.443 alpha:1.00] description:@"浦发"]];
        }

        [self fetchMonthData];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
            self.lblTotal.attributedText = [self updateLabel:@"总金额：" value:self.total];
            self.lblCost.attributedText = [self updateLabel:@"总消耗：" value:self.cost];
            
            [self.pieChart updateChartData:items];
            [self.pieChart strokeChart];
            
            [self.tableView reloadData];
        });

    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - touch action

- (void)reloadUI {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 240;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.barDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWHalfYearSummaryCell *summaryCell = [tableView dequeueReusableCellWithClass:HWHalfYearSummaryCell.class forIndexPath:indexPath];
    [summaryCell updateSummaryCell:self.barDataSource[indexPath.row]];
    summaryCell.delegate = self;
    return summaryCell;
}

#pragma mark - HalfYearSummaryCellDelegate

- (void)yearSummaryCell:(HWHalfYearSummaryCell *)cell didTapBarAtIndex:(NSInteger)index {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    NSNumber *bankType = @(indexPath.row + 1);
    HWDateRangeModel *dateRangeModel = self.dateRangeList[(NSUInteger) index];

    HWMonthDataListController *monthDataListController = [HWMonthDataListController new];
    monthDataListController.bankType = bankType;
    monthDataListController.dateRange = dateRangeModel;

    [self.navigationController pushViewController:monthDataListController animated:YES];
}


#pragma mark - private method

- (NSAttributedString *)updateLabel:(NSString *)title value:(NSNumber *)value {
    NSString *valueStr = [NSString stringWithFormat:@"%.2f", value.floatValue];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%@", title, valueStr]];
    [attr addAttributes:@{NSForegroundColorAttributeName: [UIColor darkTextColor], NSFontAttributeName: [UIFont systemFontOfSize:16]} range:NSMakeRange(0, title.length)];
    [attr addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:1.000 green:0.161 blue:0.408 alpha:1.00], NSFontAttributeName: [UIFont systemFontOfSize:30 weight:UIFontWeightSemibold]} range:NSMakeRange(title.length, valueStr.length)];
    return attr;
}

- (void)fetchMonthData {
    NSMutableArray *dataSource = [NSMutableArray arrayWithCapacity:3];
    NSArray *bankList = [HWAppConfig sharedInstance].bankTypeList;

    for (int i = 0; i < 3; i ++) {

        NSMutableArray *valueList = [NSMutableArray arrayWithCapacity:6];
        NSMutableArray *monthNames = [NSMutableArray arrayWithCapacity:6];

        for (int j = 0; j <= 5; j ++) {
            HWDateRangeModel *dateRangeModel = self.dateRangeList[j];
            NSDate *beginDate = dateRangeModel.beginDate;
            NSDate *lastDate = dateRangeModel.endDate;

            NSNumber *total = [[[HWRandom objectsWhere:@"randomDate >= %@ AND randomDate <= %@", beginDate, lastDate] objectsWhere:@"bankType == %@", @(i + 1)] sumOfProperty:@"value"];
            [monthNames addObject:[beginDate formattedDateWithFormat:@"yy/MM"]];

            if (total) {
                [valueList addObject:total];
            } else {
                [valueList addObject:@0];
            }
        }

        HWSummaryMonthModel *monthModel = [HWSummaryMonthModel new];
        monthModel.typeName = bankList[i];
        monthModel.yValues = valueList;
        monthModel.xLabels = monthNames;
//        NSLog(@">%@", monthModel);

        [dataSource addObject:monthModel];

    }
    self.barDataSource = dataSource;


}

#pragma mark - Getter

- (UILabel *)lblTotal {
    if (!_lblTotal) {
        _lblTotal = [UILabel labelWithAlignment:NSTextAlignmentLeft];
        _lblTotal.attributedText = [self updateLabel:@"总金额：" value:@0];
    }
    return _lblTotal;
}

- (UILabel *)lblCost {
    if (!_lblCost) {
        _lblCost = [UILabel labelWithAlignment:NSTextAlignmentLeft];
        _lblCost.attributedText = [self updateLabel:@"总消耗：" value:@0];
    }
    return _lblCost;
}

- (PNPieChart *)pieChart {
    if (!_pieChart) {
        _pieChart = [[PNPieChart alloc] initWithFrame:CGRectMake(0, 0, 240, 240) items:nil];
    }
    return _pieChart;
}

- (UIView *)tableHeader {
    if (!_tableHeader) {
        _tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 367)];
    }
    return _tableHeader;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];

        [_tableView registerClass:[HWHalfYearSummaryCell class]];

        _tableView.delegate = self;
        _tableView.dataSource = self;

    }
    return _tableView;
}

- (NSArray<HWDateRangeModel *> *)dateRangeList {
    if (!_dateRangeList) {
        NSDate *nowDate = [NSDate date];
        NSMutableArray<HWDateRangeModel *> *tmpList = [NSMutableArray arrayWithCapacity:6];

        for (int j = 5; j >= 0; j --) {
            NSDate *lessDate = [nowDate dateByAddingMonths:-j];

            NSDate *beginDate = [NSDate dateWithYear:lessDate.year month:lessDate.month day:1];

            NSDate *nextMonth = [lessDate dateByAddingMonths:1];
            NSDate *lastDate = [[NSDate dateWithYear:nextMonth.year month:nextMonth.month day:1] dateByAddingSeconds:-1];

            NSLog(@"%@ %@", [beginDate formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"], [lastDate formattedDateWithFormat:@"yyyy-MM-dd HH:mm:ss"]);
            HWDateRangeModel *dateRangeModel = [HWDateRangeModel new];
            dateRangeModel.beginDate = beginDate;
            dateRangeModel.endDate = lastDate;
            [tmpList addObject:dateRangeModel];
        }

        _dateRangeList = tmpList;
    }
    return _dateRangeList;
}


@end
