//
//  UIButton+Addition.m
//  CategoryCollection
//
//  Created by Heath on 27/03/2017.
//  Copyright © 2017 Heath. All rights reserved.
//

#import <objc/runtime.h>

@implementation UIButton (Addition)

+ (instancetype)buttonWithFont:(UIFont *)font title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}

+ (instancetype)buttonWithFont:(UIFont *)font title:(NSString *)title textColor:(UIColor *)color {
    UIButton *button = [UIButton buttonWithFont:font title:title];
    [button setTitleColor:color forState:UIControlStateNormal];
    return button;
}

+ (instancetype)buttonWithFont:(UIFont *)font title:(NSString *)title textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor {
    UIButton *button = [UIButton buttonWithFont:font title:title textColor:color];
    [button setBackgroundImage:[UIImage imageWithColor:bgColor] forState:UIControlStateNormal];
    return button;
}

+ (instancetype)buttonWithFont:(UIFont *)font title:(NSString *)title textColor:(UIColor *)color cornerRadius:(CGFloat)radius {
    UIButton *button = [UIButton buttonWithFont:font title:title textColor:color];
    button.layer.cornerRadius = radius;
    button.clipsToBounds = YES;
    return button;
}

+ (instancetype)buttonWithNormalImage:(UIImage *)normalImg highlightedImage:(UIImage *)highlightedImg {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:normalImg forState:UIControlStateNormal];
    [button setImage:highlightedImg forState:UIControlStateHighlighted];
    return button;
}

@end


@implementation UIButton (ExpandClickArea)

@dynamic hitTestEdgeInsets;

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

-(void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

@end
