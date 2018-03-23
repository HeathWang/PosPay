//
//  HWTypeSelectCell.h
//  RandomPay
//
//  Created by Heath on 22/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HWTypeSelectView;

@interface HWTypeSelectCell : UITableViewCell

@property (nonatomic, strong) HWTypeSelectView *typeSelectView;

- (void)updateCellList:(NSArray *)list selectedIndex:(NSInteger)index;

+ (CGFloat)calculateCellHeight:(NSInteger)count;

@end
