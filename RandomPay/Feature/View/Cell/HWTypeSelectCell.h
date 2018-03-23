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

+ (CGFloat)calculateCellHeight:(NSInteger)count;

- (void)updateCellList:(NSArray *)list;



@end
