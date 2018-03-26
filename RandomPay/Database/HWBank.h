//
//  HWBank.h
//  RandomPay
//
//  Created by Heath on 26/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Realm/Realm.h>
// 银行model
@interface HWBank : RLMObject

@property NSString *bankId;
@property NSString *bankName;
@property NSNumber<RLMInt> *weight;

@end
