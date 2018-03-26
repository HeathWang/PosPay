//
//  HWTag.h
//  RandomPay
//
//  Created by Heath on 26/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Realm/Realm.h>

@interface HWTag : RLMObject

@property NSString *tagId;
@property NSString *tagName;
@property NSDate *updateDate;

@end
