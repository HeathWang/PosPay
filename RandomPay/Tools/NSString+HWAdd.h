//
//  NSString+HWAdd.h
//  RandomPay
//
//  Created by Heath on 11/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HWAdd)

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthForFont:(UIFont *)font;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;
@end
