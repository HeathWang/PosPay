//
//  HWQueryOptionsView.h
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HWQueryOptionsView : UIView

@property (nonatomic, copy) NSDate *startDate;
@property (nonatomic, copy) NSDate *endDate;
@property (nonatomic, weak) UIViewController *viewController;

@property (nonatomic, readonly) NSInteger filterCostPercent;
@property (nonatomic, readonly) NSInteger filterBank;
@property (nonatomic, readonly) NSInteger filterPosType;

- (void)updateSelectDate;
@end
