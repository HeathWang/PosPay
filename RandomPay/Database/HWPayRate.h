//
//  HWPayRate.h
//  RandomPay
//
//  Created by Heath on 26/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Realm/Realm.h>

// 支付费率 0.38， 0.60
@interface HWPayRate : RLMObject

@property NSString *rateId;
@property NSNumber<RLMFloat> *rate;
@property NSNumber<RLMInt> *weight;

@end
