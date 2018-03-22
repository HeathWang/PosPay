//
//  MBProgressHUD+VBAdd.m
//  VoiceBook
//
//  Created by Heath on 16/8/1.
//  Copyright © 2016年 Heath. All rights reserved.
//

#import <MBProgressHUD.h>
@implementation MBProgressHUD (VBAdd)

+ (instancetype)vb_HUDForView:(UIView *)view {
    if (!view) {
        return nil;
    }
    MBProgressHUD *hud = [MBProgressHUD HUDForView:view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.cornerRadius = 6.f;
    hud.dimBackground = NO;
    hud.animationType = MBProgressHUDAnimationFade;

    hud.labelFont = [UIFont systemFontOfSize:14];
    hud.detailsLabelFont = [UIFont systemFontOfSize:14];

    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (void)showHUDWithMessage:(NSString *)message toView:(UIView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD vb_HUDForView:view];
        hud.detailsLabelText = message;
    });

}

+ (void)showCustomView:(UIView *)customView text:(NSString *)text toView:(UIView *)view hideDelay:(NSTimeInterval)delay userInteractionEnabled:(BOOL)enabled {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD vb_HUDForView:view];
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = customView;
        hud.detailsLabelText = text;
        hud.userInteractionEnabled = enabled;
        [hud hide:YES afterDelay:delay];
    });
}

+ (void)showInfo:(NSString *)info toView:(UIView *)view {
    [MBProgressHUD showInfo:info toView:view hideDelay:1.5];
}

+ (void)showInfo:(NSString *)info toView:(UIView *)view hideDelay:(NSTimeInterval)delay {
    [MBProgressHUD showCustomView:[UIView new] text:info toView:view hideDelay:delay userInteractionEnabled:YES];
}

+ (void)showNoBlockTip:(NSString *)tip toView:(UIView *)view hideDelay:(NSTimeInterval)delay {
    [MBProgressHUD showCustomView:[UIView new] text:tip toView:view hideDelay:delay userInteractionEnabled:NO];
}

+ (void)showFooterText:(NSString *)text toView:(UIView *)view {
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD vb_HUDForView:view];
        hud.mode = MBProgressHUDModeText;
        hud.detailsLabelText = text;
        CGFloat height = CGRectGetHeight(view.frame);
        hud.yOffset = height / 2 - 88;
        hud.margin = 8;
        hud.opacity = 0.7;
        hud.userInteractionEnabled = NO;
        hud.animationType = MBProgressHUDAnimationFade;
        [hud hide:YES afterDelay:1.0];
    });
}

@end
