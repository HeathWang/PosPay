//
//  HWPayRate.m
//  RandomPay
//
//  Created by Heath on 26/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWPayRate.h"

@implementation HWPayRate

+ (NSString *)primaryKey {
    return @"rateId";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"weight": @(1), @"rateId": [NSUUID UUID].UUIDString};
}

@end
