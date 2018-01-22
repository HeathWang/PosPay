 //
//  UIFont+ElAdd.h
//  ella
//
//  Created by Heath on 24/05/2017.
//  Copyright © 2017 joindata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (ElAdd)

/**
 * 默认字体 14号
 * @return Font
 */
+ (UIFont *)ep_defaultFont;
/**
 * 默认小字体 12号
 * @return font
 */
+ (UIFont *)ep_smallFont;
/**
 * 中等字体 16号
 * @return font
 */
+ (UIFont *)ep_mediumFont;
/**
 * 大字体 28号
 * @return
 */
+ (UIFont *)ep_largeFont;

/**
 * 导航栏字体 17号，不根据设备改变字体
 * @return font
 */
+ (UIFont *)ep_navFont;

/**
 * 数字显示大字体
 * @return
 */
+ (UIFont *)ep_largeNumberFont;

/**
 * 数字显示小字体
 * @return
 */
+ (UIFont *)ep_defaultNumberFont;

/**
 * 最小字体
 * @return
 */
+ (UIFont *)ep_ministFont;


/**
 * 默认用的是Regular字体
 * @param size
 */
+ (UIFont *)ep_defaultFontOfSize:(CGFloat)size;
+ (UIFont *)ep_defaultBoldFontSize:(CGFloat)size;

/**
 * @see  ep_defaultFontOfSize 现在调用结果相同
 */
+ (UIFont *)ep_regularFontSize:(CGFloat)size;

/**
 * medium font
 */
+ (UIFont *)ep_mediumFontSize:(CGFloat)size;

/**
 * light font
 */
+ (UIFont *)ep_lightFontSize:(CGFloat)size;

+ (UIFont *)ep_numberFontSize:(CGFloat)size;

@end
