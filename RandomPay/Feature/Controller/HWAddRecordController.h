//
//  HWAddRecordController.h
//  RandomPay
//
//  Created by Heath on 01/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "BaseViewController.h"
#import "HWDatePickerView.h"

@interface HWAddRecordController : BaseViewController <HWDatePickerViewDelegate>

@property (nonatomic, assign) BOOL isEdit;
@property (nonatomic, copy) NSString *rid;

@end
