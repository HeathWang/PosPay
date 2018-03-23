//
//  UIView+HWAdd.h
//  RandomPay
//
//  Created by Heath on 23/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HWAdd)

/**
 Returns the view's view controller (may be nil).
 */
@property (nullable, nonatomic, readonly) UIViewController *viewController;

@property (nullable, nonatomic, readonly) UITableViewCell *tableViewCell;

@end
