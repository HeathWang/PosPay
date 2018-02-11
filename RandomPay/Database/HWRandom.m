//
//  HWRandom.m
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//Copyright © 2018 heathwang. All rights reserved.
//

#import "HWRandom.h"
#import "NSNumber+Random.h"

@implementation HWRandom

// Specify default values for properties

+ (nullable NSString *)primaryKey {
    return @"rid";
}

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"value": @0,
            @"rid": [NSUUID UUID].UUIDString,
            @"costPercent": @0.006,
            @"bankType": @(1)};
}

// Specify properties to ignore (Realm won't persist these)

+ (NSArray *)ignoredProperties
{
    return @[@"isDetail"];
}

+ (NSNumber *)getUniqueRandomFrom:(NSInteger)from to:(NSInteger)to ignoreDigits:(BOOL)ignoreDigits hasDecimals:(BOOL)hasDecimals {
    NSNumber *result = [NSNumber randomFrom:from to:to ignoreDigits:ignoreDigits hasDecimals:hasDecimals];
    if ([HWRandom checkIfExists:result]) {
        result = [HWRandom getUniqueRandomFrom:from to:to ignoreDigits:ignoreDigits hasDecimals:hasDecimals];
    }
    return result;
}

+ (BOOL)checkIfExists:(NSNumber *)result {
    RLMResults *queryResults = [HWRandom objectsWhere:@"value == %@", result];
    return queryResults.count > 0;
}


- (NSNumber *)getPosValue {
    return @(self.value.floatValue * (1 - self.costPercent.floatValue));
}

@end
