//
//  HWPayType.h
//  RandomPay
//
//  Created by Heath on 26/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Realm/Realm.h>

// 支付类型 刷卡，支付宝
@interface HWPayType : RLMObject

@property NSString *payTypeID;
@property NSString *payTypeName;
@property NSNumber<RLMInt> *weight;

@end
