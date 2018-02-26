//
//  HWMonthDataListController.m
//  RandomPay
//
//  Created by Heath on 11/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <DateTools/DateTools.h>
#import "HWMonthDataListController.h"
#import "HWDateRangeModel.h"
#import "RLMResults.h"
#import "HWRandom.h"
#import "HWRandomHistoryCell.h"

@interface HWMonthDataListController () <UITableViewDelegate, UITableViewDataSource>


@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RLMResults<HWRandom *> *dataList;

@end

@implementation HWMonthDataListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [NSString stringWithFormat:@"%@详情", [self.dateRange.beginDate formattedDateWithFormat:@"yy年MM月"]];
    [self setupData];
    [self setupView];
}

- (void)setupData {
    self.dataList = [[HWRandom objectsWhere:@"randomDate >= %@ AND randomDate <= %@ AND bankType = %@", self.dateRange.beginDate, self.dateRange.endDate, self.bankType] sortedResultsUsingKeyPath:@"randomDate" ascending:NO];
}

- (void)setupView {
    [self.view addSubview:self.tableView];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
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

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWRandomHistoryCell *cell = [tableView dequeueReusableCellWithClass:HWRandomHistoryCell.class];
    HWRandom *random = self.dataList[indexPath.row];
    random.isDetail = YES;
    [cell updateCell:random];

    return cell;
}


#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];

        [_tableView registerClass:HWRandomHistoryCell.class];

        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}


@end
