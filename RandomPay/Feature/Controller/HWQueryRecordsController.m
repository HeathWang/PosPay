//
//  HWQueryRecordsController.m
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Realm/RLMResults.h>
#import "HWQueryRecordsController.h"
#import "HWQueryOptionsView.h"
#import "DateTools.h"
#import "HWRandomHistoryCell.h"
#import "HWDaySectionHeader.h"
#import "HWRandom.h"

@interface HWQueryRecordsController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HWQueryOptionsView *optionsView;

// data filter
@property (nonatomic, copy) NSDate *startDate;
@property (nonatomic, copy) NSDate *endDate;

@property (nonatomic, strong) RLMResults<HWRandom *> *results;

@end

@implementation HWQueryRecordsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupData];
    [self setupNav];
    [self setupView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNav {
    self.navigationItem.title = @"查询";
}

- (void)setupData {
    NSDate *date = [NSDate date];
    self.startDate = [NSDate dateWithYear:date.year month:date.month day:date.day hour:0 minute:0 second:0];
    NSDate *nextMonth = [self.startDate dateByAddingMonths:1];
    self.endDate = [nextMonth dateByAddingSeconds:-1];

}

- (void)setupView {
    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];

    self.tableView.tableHeaderView = self.optionsView;
    [self.optionsView updateSelectDate];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HWDaySectionHeader *sectionHeader = [tableView dequeueReusableHeaderFooterViewWithClass:HWDaySectionHeader.class];

    return sectionHeader;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.results.count > 0) {
        return 1;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWRandomHistoryCell *cell = [tableView dequeueReusableCellWithClass:HWRandomHistoryCell.class];
    return cell;
}

#pragma mark - Getter


- (HWQueryOptionsView *)optionsView {
    if (!_optionsView) {
        _optionsView = [[HWQueryOptionsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 214)];
        _optionsView.startDate = self.startDate;
        _optionsView.endDate = self.endDate;
    }
    return _optionsView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];

        [_tableView registerClass:HWRandomHistoryCell.class];
        [_tableView registerHeaderFooterClass:HWDaySectionHeader.class];

        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
