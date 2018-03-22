//
//  HWSummaryMonthModel.m
//  RandomPay
//
//  Created by Heath on 05/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWSummaryMonthModel.h"

@implementation HWSummaryMonthModel

- (NSString *)description {
    return [NSString stringWithFormat:@"bank: %@, xLabels: %@, yLabels:%@", self.typeName, self.xLabels, self.yValues];
}

@end
