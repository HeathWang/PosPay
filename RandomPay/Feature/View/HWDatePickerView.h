//
//  HWDatePickerView.h
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWDatePickerViewDelegate <NSObject>

- (void)didPicketDate:(NSDate *)pickedDate;
@optional
- (NSDate *)requireCurrentDate;

@end

@interface HWDatePickerView : UIView

@property (nonatomic, weak) id <HWDatePickerViewDelegate> delegate;


+ (void)showInView:(UIView *)view delegate:(id <HWDatePickerViewDelegate>)delegate;
@end
