//
//  HWSummaryMonthModel.h
//  RandomPay
//
//  Created by Heath on 05/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWSummaryMonthModel : NSObject

@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSArray *xLabels;
@property (nonatomic, copy) NSArray *yValues;
@property (nonatomic, assign) BOOL hasStroke;

@end
