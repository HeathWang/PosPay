//
//  HWTypeSelectView.h
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HWTypeSelectView : UIView

@property (nonatomic, assign, readonly) NSInteger selectIndex;

- (instancetype)initWithTypeList:(NSArray *)typeList;

+ (instancetype)viewWithTypeList:(NSArray *)typeList;


@end
