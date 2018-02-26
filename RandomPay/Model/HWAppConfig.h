//
//  HWAppConfig.h
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWAppConfig : NSObject

@property (nonatomic, readonly) NSArray *posCostStrList;
@property (readonly) NSArray *postCostValueList;
@property (nonatomic, readonly) NSArray *bankTypeList;

+ (instancetype)sharedInstance;
@end
