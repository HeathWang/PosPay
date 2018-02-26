//
//  HWPosTypeCollectionCell.m
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWPosTypeCollectionCell.h"

@interface HWPosTypeCollectionCell ()

@property (nonatomic, strong) UIButton *btnType;

@end

@implementation HWPosTypeCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];

        CGSize buttonSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame));
        _btnType = [UIButton buttonWithType:UIButtonTypeCustom];

        [_btnType setBackgroundImage:[[UIImage imageWithColor:[UIColor whiteColor] size:buttonSize] imageByRoundCornerRadius:6 borderWidth:2.f borderColor:[UIColor colorWithRed:0.667 green:0.667 blue:0.667 alpha:1.00]] forState:UIControlStateNormal];
        [_btnType setBackgroundImage:[[UIImage imageWithColor:kThemeColor size:buttonSize] imageByRoundCornerRadius:10] forState:UIControlStateSelected];

        _btnType.titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightHeavy];
        [_btnType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_btnType setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];

        [self.contentView addSubview:_btnType];
        [_btnType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(CGPointZero);
            make.size.mas_equalTo(buttonSize);
        }];

        UIView *tmpView = [UIView new];
        [self.contentView addSubview:tmpView];
        [tmpView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)updateButtonText:(NSString *)text isSelected:(BOOL)isSelected {
    [self.btnType setTitle:text forState:UIControlStateNormal];
    self.btnType.selected = isSelected;
}

@end
