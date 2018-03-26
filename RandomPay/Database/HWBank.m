//
//  HWBank.m
//  RandomPay
//
//  Created by Heath on 26/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWBank.h"

@implementation HWBank

+ (NSString *)primaryKey {
    return @"bankId";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"weight": @(1), @"bankId": [NSUUID UUID].UUIDString};
}

@end
