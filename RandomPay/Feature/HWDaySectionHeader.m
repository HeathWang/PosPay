//
//  HWDaySectionHeader.m
//  RandomPay
//
//  Created by Heath on 26/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWDaySectionHeader.h"

@implementation HWDaySectionHeader

- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _lblTitle = [UILabel labelWithAlignment:NSTextAlignmentLeft textColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:14 weight:UIFontWeightLight]];

        self.contentView.backgroundColor = [UIColor colorWithRed:0.667 green:0.667 blue:0.667 alpha:1.00];
        [self.contentView addSubview:_lblTitle];

        [_lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.centerY.equalTo(@0);
        }];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
