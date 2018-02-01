//
//  HWRandomHistoryCell.h
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell.h>

@class HWRandom;

@interface HWRandomHistoryCell : MGSwipeTableCell

- (void)updateCell:(HWRandom *)random;
@end
