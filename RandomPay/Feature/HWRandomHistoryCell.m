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

@property (nonatomic, strong) UILabel *lblDate;
@property (nonatomic, strong) UILabel *lblValue;

@end

@implementation HWRandomHistoryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.lblDate];
        [self.contentView addSubview:self.lblValue];

        [self.lblDate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.left.equalTo(@14);
        }];

        [self.lblValue mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.right.equalTo(@-14);
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
    self.lblDate.text = [random.randomDate formattedDateWithFormat:@"HH:mm:ss"];
    self.lblValue.text = [NSString stringWithFormat:@"%.1f ¥", random.value.floatValue];
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


@end
