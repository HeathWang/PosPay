//
//  HWHalfYearSummaryCell.h
//  RandomPay
//
//  Created by Heath on 05/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWSummaryMonthModel;
@class HWHalfYearSummaryCell;

@protocol HalfYearSummaryCellDelegate <NSObject>

- (void)yearSummaryCell:(HWHalfYearSummaryCell *)cell didTapBarAtIndex:(NSInteger)index;

@end


@interface HWHalfYearSummaryCell : UITableViewCell

- (void)updateSummaryCell:(HWSummaryMonthModel *)summaryMonth;

@property (nonatomic, weak) id <HalfYearSummaryCellDelegate> delegate;

@end
