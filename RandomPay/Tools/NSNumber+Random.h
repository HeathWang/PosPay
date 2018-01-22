//
//  NSNumber+Random.h
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Random)

+ (NSNumber *)randomFrom:(NSInteger)min to:(NSInteger)max ignoreDigits:(BOOL)ignoreDigits hasDecimals:(BOOL)hasDecimals;

@end
