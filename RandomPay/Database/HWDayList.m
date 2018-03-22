//
//  HWDayList.m
//  RandomPay
//
//  Created by Heath on 26/01/2018.
//Copyright © 2018 heathwang. All rights reserved.
//

#import "HWDayList.h"

@implementation HWDayList

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}


+ (NSString *)primaryKey {
    return @"dayId";
}

+ (NSArray<NSString *> *)indexedProperties {
    return @[@"dayId"];
}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
