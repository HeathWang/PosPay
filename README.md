# PosPay
个人业余娱乐项目

## 前言
生活中，很多地方会消费，为了消费便捷，本人大部分时候会用信用卡支付。
而实际支付过程中，为了便利，会在`支付宝`、`微信`平台绑定信用卡进行支付。
各个银行的信用卡，都会定时推出一些活动，比如：`刷xxx金额送xxx实物，活动达标送积分等。`浦发就有高端5倍积分的活动，每个月刷支付宝微信有5倍积分，最高每平台50000，按照刷卡基础分2倍，也就是需要刷50000/3=16666.666666667元。于是这些金额的记录和计算就成了问题，所以自己写了一个简单的APP，用来记录日常消费。

## 功能介绍
1. 金额数值随机。在模拟实际消费时，消费金额最好不是整金额，如18888，20000，5000等。所以程序可以设置一个区间，随机该区间。支持随机到十分位的小数，支持金额必为10的倍数。
2. 支持可以选择国内的大部分银行，可通过银行图标区分。
3. 支持选择费率。tx费率一般为0，0.38%，0.60%，1%。
4. 支持选择刷卡平台。商户pos机，支付宝，微信。
5. 消费记录的删除修改。
6. 消费记录区间查询，金额汇总。
7. 数据报表。

*具体见底部截图*

## 核心实现
###### 持久化存储：RealmCocoa。使用了Realm来存储数据，数据变化即时刷新UI。

```
- (void)addDataBaseObserver {
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
```
###### Realm查询汇总数据，`sumOfProperty`方法

```
NSNumber *total = [[[HWRandom objectsWhere:@"randomDate >= %@ AND randomDate <= %@", beginDate, lastDate] objectsWhere:@"bankType == %@", @(i + 1)] sumOfProperty:@"value"];
```
######  主页的数据按照天来分组。而Realm数据库目前还不支持分组，所以在表结构的设计上，设计了一张消费记录表，包含最基本的属性：时间，金额，类别等。

```
@interface HWRandom : RLMObject

@property NSString *rid;    //主键id
@property NSDate *randomDate;   // 随机日期
@property NSNumber<RLMFloat> *value;    // 随机数值
@property NSNumber<RLMFloat> *costPercent;  // 刷卡损耗
/**
 * 归属银行 1-中信 2-招商 3-浦发 4-中国银行 5-交通银行 6-工商 7-广发 8-建设 9-民生 10-农业 11-兴业 12-花旗
 */
@property NSNumber<RLMInt> *bankType;
@property NSNumber<RLMInt> *posType;    // 刷卡类型 1-POS机 2-支付宝 3-微信
@property BOOL isDetail;
@end
```
另外在建立一张表`HWDayList`，此张表可以关联多个消费记录，实际主页查询的是HWDayList表，表中关联的消费记录即为cell。

```
@interface HWDayList : RLMObject

@property NSNumber<RLMInt> *dayId;
@property NSString *dateStr;
@property RLMArray<HWRandom *><HWRandom> *randoms; // 一对多关联

@end
```

## 相关类库
* Masonry，自动布局
* DateTools，方便地使用时间
* Realm，持久化数据库
* IQKeyboardManager
* MGSwipeTableCell，侧滑出现多菜单
* PNChart，图标展示
* DZNEmptyDataSet，空视图
* XHLaunchAd，广告加载（just for practice）

### 部分截图
![-w300](https://raw.githubusercontent.com/HeathWang/PosPay/master/screenshot/IMG_8096.jpg)

![-w300](https://raw.githubusercontent.com/HeathWang/PosPay/master/screenshot/IMG_8097.jpg)

![-w300](https://raw.githubusercontent.com/HeathWang/PosPay/master/screenshot/IMG_8098.jpg)

![-w300](https://raw.githubusercontent.com/HeathWang/PosPay/master/screenshot/IMG_8099.jpg)



