//
//  HWRandomMainController.m
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWRandomMainController.h"
#import "HWRandomView.h"
#import "HWRandomHistoryCell.h"
#import "RLMResults.h"
#import "HWRandom.h"
#import "HWDayList.h"
#import "HWDaySectionHeader.h"

@interface HWRandomMainController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) HWRandomView *headerView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RLMResults<HWDayList *> *historyList;
@property (nonatomic, strong) RLMNotificationToken *token;

@end

@implementation HWRandomMainController

- (void)viewDidLoad {

    [super viewDidLoad];
    [self setupNav];
    [self setupData];
    [self setupView];
}

- (void)setupNav {
    self.navigationItem.title = @"RANDOM";
}

- (void)setupView {
    [self.view addSubview:self.self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
}

- (void)setupData {
    self.historyList = [[HWDayList allObjects] sortedResultsUsingKeyPath:@"dayId" ascending:NO];

    __weak typeof(self) weakSelf = self;
    self.token = [self.historyList addNotificationBlock:^(RLMResults<HWDayList *> *results, RLMCollectionChange *change, NSError *error) {
        UITableView *tableView1 = weakSelf.tableView;

        if (!change) {
            [tableView1 reloadData];
            return;
        }

        [tableView1 beginUpdates];
        for (NSNumber *section in change.modifications) {
            [tableView1 reloadSection:section.integerValue withRowAnimation:UITableViewRowAnimationFade];
        }

        [tableView1 endUpdates];

    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HWDaySectionHeader *sectionHeader = [tableView dequeueReusableHeaderFooterViewWithClass:HWDaySectionHeader.class];
    HWDayList *dayList = self.historyList[section];
    sectionHeader.lblTitle.text = dayList.dateStr;
    return sectionHeader;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.historyList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    HWDayList *dayList = self.historyList[section];
    return dayList.randoms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWRandomHistoryCell *cell = [tableView dequeueReusableCellWithClass:HWRandomHistoryCell.class];
    HWDayList *dayList = self.historyList[indexPath.section];
    HWRandom *hwRandom = dayList.randoms[indexPath.row];
    [cell updateCell:hwRandom];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    HWDayList *dayList = self.historyList[indexPath.section];
    HWRandom *hwRandom = dayList.randoms[indexPath.row];
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteObject:hwRandom];
    [realm commitWriteTransaction];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}


#pragma mark - touch action


#pragma mark - Getter

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

- (HWRandomView *)headerView {
    if (!_headerView) {
        _headerView = [[HWRandomView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 230)];
    }
    return _headerView;
}


- (void)dealloc {
    [self.token invalidate];
}


@end
