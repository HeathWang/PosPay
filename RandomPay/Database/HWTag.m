//
//  HWTag.m
//  RandomPay
//
//  Created by Heath on 26/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWTag.h"

@implementation HWTag

+ (NSString *)primaryKey {
    return @"tagId";
}

+ (NSDictionary *)defaultPropertyValues {
    return @{@"updateDate": [NSDate date], @"tagId": [NSUUID UUID].UUIDString};
}

@end
