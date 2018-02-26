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

- (instancetype)init {
    self = [super init];
    if (self) {
        _posCostStrList = @[@"0.00", @"0.38", @"0.60", @"1.00"];
        _postCostValueList = @[@0, @(0.0038f), @(0.0060f), @(0.0100f)];
        _bankTypeList = @[@"中信", @"招商", @"浦发"];
    }
    return self;
}


@end
