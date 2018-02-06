//
//  HWHalfYearSummaryCell.h
//  RandomPay
//
//  Created by Heath on 05/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWSummaryMonthModel;

@interface HWHalfYearSummaryCell : UITableViewCell

- (void)updateSummaryCell:(HWSummaryMonthModel *)summaryMonth;
@end
