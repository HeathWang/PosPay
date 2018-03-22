//
//  HWMonthDataListController.h
//  RandomPay
//
//  Created by Heath on 11/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@class HWDateRangeModel;

@interface HWMonthDataListController : BaseViewController

@property (nonatomic, copy) NSNumber *bankType;
@property (nonatomic, strong) HWDateRangeModel *dateRange;

@end
