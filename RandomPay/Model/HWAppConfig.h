//
//  HWAppConfig.h
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAppConfig : NSObject

@property (nonatomic, readonly) NSArray *posCostStrList;    // 刷卡费率string list
@property (nonatomic, readonly) NSArray *posCostValueList;  // 刷卡费率数值list， NSNumber
@property (nonatomic, readonly) NSArray *bankTypeList;      // 银行列表
@property (nonatomic, readonly) NSArray *posTypeList;       // 刷卡类型list

+ (instancetype)sharedInstance;
@end
