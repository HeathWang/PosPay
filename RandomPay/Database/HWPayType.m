//
//  HWPayType.m
//  RandomPay
//
//  Created by Heath on 26/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWPayType.h"

@implementation HWPayType

+ (NSString *)primaryKey {
    return @"payTypeID";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"weight": @(1), @"payTypeID": [NSUUID UUID].UUIDString};
}

@end
