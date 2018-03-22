//
//  UIFont+ElAdd.m
//  ella
//
//  Created by Heath on 24/05/2017.
//  Copyright © 2017 joindata. All rights reserved.
//

@implementation UIFont (ElAdd)

+ (UIFont *)ep_defaultFont {
    return [UIFont ep_defaultFontOfSize:14];
}

+ (UIFont *)ep_smallFont {
    return [UIFont ep_defaultFontOfSize:12];
}

+ (UIFont *)ep_mediumFont {
    return [UIFont ep_defaultFontOfSize:16];
}

+ (UIFont *)ep_largeFont {
    return [UIFont ep_defaultFontOfSize:28];
}

+ (UIFont *)ep_navFont {
    return [UIFont systemFontOfSize:17];
}

+ (UIFont *)ep_largeNumberFont {
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:IPHONEFONT(28)];
}

+ (UIFont *)ep_defaultNumberFont {
    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:IPHONEFONT(16)];
}

+ (UIFont *)ep_ministFont {
    return [UIFont ep_defaultFontOfSize:10];
}

#pragma mark - base

+ (UIFont *)ep_defaultFontOfSize:(CGFloat)size {
//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.2")) {
//        return [UIFont systemFontOfSize:IPHONEFONT(size) weight:UIFontWeightRegular];
//    } else {
//        return [UIFont fontWithName:@"HelveticaNeue-Regular" size:IPHONEFONT(size)];
//    }
    // 不要问我为什么，最初版本用的light字体。
    return [UIFont systemFontOfSize:IPHONEFONT(size)];
}

+ (UIFont *)ep_defaultBoldFontSize:(CGFloat)size {
    return [UIFont boldSystemFontOfSize:IPHONEFONT(size)];
}

+ (UIFont *)ep_regularFontSize:(CGFloat)size {
    return [UIFont systemFontOfSize:IPHONEFONT(size)];
}

+ (UIFont *)ep_mediumFontSize:(CGFloat)size {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.2")) {
        return [UIFont systemFontOfSize:IPHONEFONT(size) weight:UIFontWeightMedium];
    } else {
        return [UIFont fontWithName:@"HelveticaNeue-Medium" size:IPHONEFONT(size)];
    }
}

+ (UIFont *)ep_lightFontSize:(CGFloat)size {
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.2")) {
        return [UIFont systemFontOfSize:IPHONEFONT(size) weight:UIFontWeightLight];
    } else {
        return [UIFont fontWithName:@"HelveticaNeue-Light" size:IPHONEFONT(size)];
    }
}

+ (UIFont *)ep_numberFontSize:(CGFloat)size{

    return [UIFont fontWithName:@"HelveticaNeue-Medium" size:IPHONEFONT(size)];
}

@end
