//
//  HWBaseNavigationController.m
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWBaseNavigationController.h"

@interface HWBaseNavigationController ()

@property (nonatomic, strong) UIImageView *shadowImageView;

@end

@implementation HWBaseNavigationController

- (instancetype)init {
    self = [super init];
    if (self) {
        _hideLine = YES;
    }
    return self;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        _hideLine = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.shadowImageView = [self findHairlineImageViewUnder:self.navigationBar];
    [self adjustShadowLine];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self adjustShadowLine];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ __nullable)(void))completion {
    [super presentViewController:viewControllerToPresent animated:flag completion:completion];
}


#pragma mark - private method

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)adjustShadowLine {
    self.shadowImageView.hidden = self.hideLine;
    if (self.hideLine) {
        self.navigationBar.shadowImage = [UIImage new];
    }
}

- (void)setHideLine:(BOOL)hideLine {
    _hideLine = hideLine;
    self.shadowImageView.hidden = hideLine;
}

@end
