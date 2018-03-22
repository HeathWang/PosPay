//
//  UIImage+Addition.h
//  CategoryCollection
//
//  Created by Heath on 27/03/2017.
//  Copyright © 2017 Heath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Addition)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 创建条形码

 @param info <#info description#>
 @return <#return value description#>
 */
+ (UIImage *)barCodeImageWithInfo:(NSString *)info;

/**
 * Whether this image has alpha channel.
 * @return
 */
- (BOOL)hasAlphaChannel;

/**
 * corner image.
 * @param radius
 * @return
 */
- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius;

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

- (UIImage *)imageByRoundCornerRadius:(CGFloat)radius corners:(UIRectCorner)corners borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor borderLineJoin:(CGLineJoin)borderLineJoin;

- (UIImage *)originImageScaleToSize:(CGSize)size;//修改图片大小



- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;
@end

@interface UIImage (Gradient)

/**
 * 产生一个渐变图片
 * @param size 图片size
 * @param colors 渐变颜色数组
 * @param startPoint 渐变开始point
 * @param endPoint 渐变结束point
 * @return
 */
+ (UIImage *)gradientImageWithSize:(CGSize)size colors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

@end
