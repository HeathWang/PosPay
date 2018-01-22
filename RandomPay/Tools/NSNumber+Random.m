//
//  NSNumber+Random.m
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "NSNumber+Random.h"

@implementation NSNumber (Random)

+ (NSNumber *)randomFrom:(NSInteger)min to:(NSInteger)max ignoreDigits:(BOOL)ignoreDigits hasDecimals:(BOOL)hasDecimals {
    NSNumber *result;
    NSInteger origin = min + arc4random_uniform((uint32_t) (max - min + 1));
    if (ignoreDigits) {
        NSInteger digits = origin % 10;
        origin = origin - digits;
    }

    if (hasDecimals) {
        NSInteger decimals = arc4random_uniform(10);
        result = @(origin + decimals / 10.0f);
    } else {
        result = @(origin);
    }

    return result;
}

@end
