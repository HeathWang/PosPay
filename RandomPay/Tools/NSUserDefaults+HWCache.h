//
//  NSUserDefaults+HWCache.h
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (HWCache)

+ (void)cacheMinRandomValue:(NSString *)minValue maxValue:(NSString *)maxValue;

+ (NSArray *)getCacheRandomValues;
@end
