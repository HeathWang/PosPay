//
//  HWRandom.h
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//Copyright © 2018 heathwang. All rights reserved.
//

#import <Realm/Realm.h>

@interface HWRandom : RLMObject

@property NSDate *randomDate;
@property NSNumber<RLMFloat> *value;


@end

// This protocol enables typed collections. i.e.:
// RLMArray<HWRandom>
RLM_ARRAY_TYPE(HWRandom)
