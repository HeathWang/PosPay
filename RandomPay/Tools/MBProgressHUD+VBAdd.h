//
//  MBProgressHUD+VBAdd.h
//  VoiceBook
//
//  Created by Heath on 16/8/1.
//  Copyright © 2016年 Heath. All rights reserved.
//

#import <MBProgressHUD.h>

@interface MBProgressHUD (VBAdd)

/**
 * 根据view获取一个hud
 * @param view 目标view
 */
+ (instancetype)vb_HUDForView:(UIView *)view;

/**
 * 显示hud loading，block用户操作
 * @param message 可为空
 */
+ (void)showHUDWithMessage:(NSString *)message toView:(UIView *)view;

/**
 * 显示提示信息于view center，默认1.5s消失
 * @param info text
 * @param view target
 */
+ (void)showInfo:(NSString *)info toView:(UIView *)view;

+ (void)showInfo:(NSString *)info toView:(UIView *)view hideDelay:(NSTimeInterval)delay;

/**
 * 不会阻塞用户操作的tip
 */
+ (void)showNoBlockTip:(NSString *)tip toView:(UIView *)view hideDelay:(NSTimeInterval)delay;

/**
 * 显示文字于view底部
 */
+ (void)showFooterText:(NSString *)text toView:(UIView *)view;

@end
