//
//  NSUserDefaults+HWCache.m
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "NSUserDefaults+HWCache.h"

@implementation NSUserDefaults (HWCache)

+ (void)cacheMinRandomValue:(NSString *)minValue maxValue:(NSString *)maxValue {

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:minValue forKey:@"hw_random_min"];
    [defaults setValue:maxValue forKey:@"hw_random_max"];
    [defaults synchronize];
}

+ (NSArray *)getCacheRandomValues {
    NSString *min = [self getObjectWithKey:@"hw_random_min"];
    NSString *max = [self getObjectWithKey:@"hw_random_max"];

    if (min && max) {
        return @[min, max];
    } else {
        return nil;
    }
}


#pragma mark - private method

+ (void)saveObject:(id)obj key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    [defaults synchronize];
}

+ (id)getObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

@end
