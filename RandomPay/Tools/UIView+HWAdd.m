//
//  UIView+HWAdd.m
//  RandomPay
//
//  Created by Heath on 23/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "UIView+HWAdd.h"

@implementation UIView (HWAdd)

- (UIViewController *)viewController {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UITableViewCell *)tableViewCell {
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UITableViewCell class]]) {
            return (UITableViewCell *)nextResponder;
        }
    }
    return nil;
}


@end
