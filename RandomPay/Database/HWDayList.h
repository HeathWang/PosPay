//
//  HWDayList.h
//  RandomPay
//
//  Created by Heath on 26/01/2018.
//Copyright © 2018 heathwang. All rights reserved.
//

#import <Realm/Realm.h>
#import "HWRandom.h"

@interface HWDayList : RLMObject

@property NSNumber<RLMInt> *dayId;
@property NSString *dateStr;
@property RLMArray<HWRandom *><HWRandom> *randoms;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<HWDayList>
RLM_ARRAY_TYPE(HWDayList)
