//
//  HWAppConfig.m
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWAppConfig.h"

@implementation HWAppConfig

+ (instancetype)sharedInstance {
    static HWAppConfig *_sharedHWAppConfig = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedHWAppConfig = [[HWAppConfig alloc] init];
    });
    
    return _sharedHWAppConfig;
}

@end
