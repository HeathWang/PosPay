//
//  HWRandomHistoryCell.m
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWRandomHistoryCell.h"
#import "HWRandom.h"
#import "DateTools.h"

@interface HWRandomHistoryCell ()

@property (nonatomic, strong) UIImageView *imgBank;
@property (nonatomic, strong) UILabel *lblDate;

@property (nonatomic, strong) UIView *centerView;
@property (nonatomic, strong) UILabel *lblValue;
@property (nonatomic, strong) UILabel *lblCostPercent;

@end

@implementation HWRandomHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgBank];
        [self.contentView addSubview:self.lblDate];

        [self.contentView addSubview:self.centerView];
        [self.centerView addSubview:self.lblValue];
        [self.centerView addSubview:self.lblCostPercent];

        [self.imgBank mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.centerY.equalTo(@0);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];

        [self.lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.left.equalTo(self.imgBank.mas_right).offset(4);
        }];

        [self.centerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.right.equalTo(@-14);
            make.width.equalTo(self.mas_width).multipliedBy(0.6);
        }];

        [self.lblValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
        }];

        [self.lblCostPercent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.top.equalTo(self.lblValue.mas_bottom).offset(2);
        }];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)updateCell:(HWRandom *)random {

    switch (random.bankType.integerValue) {
        case 1:
            self.imgBank.image = [UIImage imageNamed:@"icon_bank_1"];
            break;
        case 2:
            self.imgBank.image = [UIImage imageNamed:@"icon_bank_2"];
            break;
        case 3:
            self.imgBank.image = [UIImage imageNamed:@"icon_bank_3"];
            break;
        default:
            self.imgBank.image = [UIImage imageNamed:@"icon_bank_1"];
            break;
    }

    self.lblDate.text = [random.randomDate formattedDateWithFormat:@"HH:mm:ss"];
    self.lblValue.text = [NSString stringWithFormat:@"%.1f ➔ %.2f", random.value.floatValue, [random getPosValue].floatValue];
    self.lblCostPercent.text = [NSString stringWithFormat:@"%.2f%%", (random.costPercent.floatValue * 100)];

    self.rightButtons = @[[MGSwipeButton buttonWithTitle:@"DELETE" backgroundColor:[UIColor colorWithRed:1.000 green:0.231 blue:0.188 alpha:1.00]],
            [MGSwipeButton buttonWithTitle:@"EDIT" backgroundColor:[UIColor colorWithRed:0.231 green:0.600 blue:0.988 alpha:1.00]]];
    self.rightSwipeSettings.transition = MGSwipeTransitionClipCenter;
    // 侧滑自动触发删除
    self.rightExpansion.buttonIndex = 0;
    self.rightExpansion.fillOnTrigger = YES;
}

#pragma mark - Getter

- (UILabel *)lblDate {
    if (!_lblDate) {
        _lblDate = [UILabel labelWithAlignment:NSTextAlignmentLeft textColor:[UIColor colorWithRed:0.500 green:0.500 blue:0.500 alpha:1.00] font:[UIFont systemFontOfSize:14] text:nil];
    }
    return _lblDate;
}

- (UILabel *)lblValue {
    if (!_lblValue) {
        _lblValue = [UILabel labelWithAlignment:NSTextAlignmentRight textColor:[UIColor colorWithRed:0.377 green:0.920 blue:1.000 alpha:1.00] font:[UIFont systemFontOfSize:14 weight:UIFontWeightHeavy]];
    }
    return _lblValue;
}

- (UIImageView *)imgBank {
    if (!_imgBank) {
        _imgBank = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_bank_1"]];
    }
    return _imgBank;
}

- (UILabel *)lblCostPercent {
    if (!_lblCostPercent) {
        _lblCostPercent = [UILabel labelWithAlignment:NSTextAlignmentRight textColor:[UIColor colorWithRed:1.000 green:0.161 blue:0.408 alpha:1.00] font:[UIFont systemFontOfSize:14 weight:UIFontWeightMedium]];
    }
    return _lblCostPercent;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView = [UIView new];
    }
    return _centerView;
}


@end
