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

@interface HWRandomMainController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) RLMResults<HWRandom *> *historyList;
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
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@0);
    }];
}

- (void)setupData {
    self.historyList = [[HWRandom allObjects] sortedResultsUsingKeyPath:@"randomDate" ascending:NO];

    __weak typeof(self) weakSelf = self;
    self.token = [self.historyList addNotificationBlock:^(RLMResults<HWRandom *> *results, RLMCollectionChange *change, NSError *error) {
        UITableView *tableView1 = weakSelf.tableView;

        if (!change) {
            [tableView1 reloadData];
            return;
        }

        // Query results have changed, so apply them to the UITableView
        [tableView1 beginUpdates];
        [tableView1 deleteRowsAtIndexPaths:[change deletionsInSection:0]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView1 insertRowsAtIndexPaths:[change insertionsInSection:0]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView1 reloadRowsAtIndexPaths:[change modificationsInSection:0]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
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
    return 230;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HWRandomView *randomView1 = [tableView dequeueReusableHeaderFooterViewWithClass:HWRandomView.class];
    return randomView1;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HWRandomHistoryCell *cell = [tableView dequeueReusableCellWithClass:HWRandomHistoryCell.class];
    HWRandom *hwRandom = self.historyList[indexPath.row];
    [cell updateCell:hwRandom];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

}


#pragma mark - touch action


#pragma mark - Getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.tableFooterView = [UIView new];

        [_tableView registerClass:HWRandomHistoryCell.class];
        [_tableView registerHeaderFooterClass:HWRandomView.class];

        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (void)dealloc {
    [self.token invalidate];
}


@end
