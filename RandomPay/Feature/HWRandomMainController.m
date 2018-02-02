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
#import "HWAddRecordController.h"
#import "HWBaseNavigationController.h"
#import "HWSummaryController.h"

@interface HWRandomMainController () <UITableViewDataSource, UITableViewDelegate, MGSwipeTableCellDelegate>

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
    UIBarButtonItem *rightAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addRecordAction)];
    self.navigationItem.rightBarButtonItem = rightAdd;

    UIBarButtonItem *summaryButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(viewSummaryAction)];
    self.navigationItem.leftBarButtonItem = summaryButton;
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
        
//        NSLog(@"%@ %@ %@", change.modifications, change.insertions, change.deletions);

        if (!change || tableView1.numberOfSections <= 0 || change.deletions.count > 0) {
            [tableView1 reloadData];
            return;
        }

        [tableView1 beginUpdates];
        
        for (NSNumber *section in change.modifications) {
            [tableView1 reloadSection:section.integerValue withRowAnimation:UITableViewRowAnimationFade];
        }
        
        for (NSNumber *section in change.insertions) {
            [tableView1 insertSection:section.integerValue withRowAnimation:UITableViewRowAnimationMiddle];
        }
        
        for (NSNumber *section in change.deletions) {
            [tableView1 deleteSection:section.integerValue withRowAnimation:UITableViewRowAnimationLeft];
        }

        [tableView1 endUpdates];

    }];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
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
    cell.delegate = self;
    HWDayList *dayList = self.historyList[indexPath.section];
    HWRandom *hwRandom = dayList.randoms[indexPath.row];
    [cell updateCell:hwRandom];
    return cell;
}

#pragma mark - MGSwipeTableCellDelegate

- (BOOL)swipeTableCell:(nonnull MGSwipeTableCell *)cell canSwipe:(MGSwipeDirection)direction fromPoint:(CGPoint)point {
    return YES;
}

- (void)swipeTableCell:(nonnull MGSwipeTableCell *)cell didChangeSwipeState:(MGSwipeState)state gestureIsActive:(BOOL)gestureIsActive {

}

- (BOOL)swipeTableCell:(nonnull MGSwipeTableCell *)cell tappedButtonAtIndex:(NSInteger)index direction:(MGSwipeDirection)direction fromExpansion:(BOOL)fromExpansion {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];

    HWDayList *dayList = self.historyList[(NSUInteger) indexPath.section];
    HWRandom *hwRandom = dayList.randoms[(NSUInteger) indexPath.row];
    RLMRealm *realm = [RLMRealm defaultRealm];

    if (index == 0) {
        // delete action
        [realm beginWriteTransaction];

        // 如果已经没有当日数据，删除日数据
        if (dayList.randoms.count == 1) {
            [realm deleteObject:dayList];
        }

        [realm deleteObject:hwRandom];
        [realm commitWriteTransaction];
    } else if (index == 1) {
        // edit action
        HWAddRecordController *addRecordController = [HWAddRecordController new];
        addRecordController.isEdit = YES;
        addRecordController.rid = hwRandom.rid;

        HWBaseNavigationController *nav = [[HWBaseNavigationController alloc] initWithRootViewController:addRecordController];
        [self.navigationController presentViewController:nav animated:YES completion:^{

        }];
    }

    return YES;
}

- (BOOL)swipeTableCell:(nonnull MGSwipeTableCell *)cell shouldHideSwipeOnTap:(CGPoint)point {
    return YES;
}


#pragma mark - touch action


- (void)addRecordAction {
    HWAddRecordController *addRecordController = [HWAddRecordController new];
    HWBaseNavigationController *nav = [[HWBaseNavigationController alloc] initWithRootViewController:addRecordController];
    [self.navigationController presentViewController:nav animated:YES completion:^{

    }];
}

- (void)viewSummaryAction {
    HWSummaryController *summaryController = [HWSummaryController new];
    [self.navigationController pushViewController:summaryController animated:YES];
}

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
