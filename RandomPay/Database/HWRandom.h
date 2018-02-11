//
//  HWRandom.h
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//Copyright © 2018 heathwang. All rights reserved.
//

#import <Realm/Realm.h>

@interface HWRandom : RLMObject

@property NSString *rid;    //主键id
@property NSDate *randomDate;   // 随机日期
@property NSNumber<RLMFloat> *value;    // 随机数值
@property NSNumber<RLMFloat> *costPercent;  // 刷卡损耗
@property NSNumber<RLMInt> *bankType;   // 归属银行 1-中信 2-招商 3-浦发
@property BOOL isDetail;

+ (NSNumber *)getUniqueRandomFrom:(NSInteger)from to:(NSInteger)to ignoreDigits:(BOOL)ignoreDigits hasDecimals:(BOOL)hasDecimals;

- (NSNumber *)getPosValue;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<HWRandom>
RLM_ARRAY_TYPE(HWRandom)
