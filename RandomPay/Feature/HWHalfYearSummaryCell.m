//
//  HWHalfYearSummaryCell.m
//  RandomPay
//
//  Created by Heath on 05/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <PNChart/PNBarChart.h>
#import "HWHalfYearSummaryCell.h"
#import "HWSummaryMonthModel.h"

@interface HWHalfYearSummaryCell () <PNChartDelegate>

@property (nonatomic, strong) PNBarChart *barChart;
@property (nonatomic, strong) UILabel *lblBank;

@end

@implementation HWHalfYearSummaryCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.barChart];
        [self.contentView addSubview:self.lblBank];

        [self.barChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.barChart.frame.size);
            make.centerX.equalTo(@0);
            make.top.equalTo(@20);
        }];

        [self.lblBank mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(@0);
            make.top.equalTo(@3);
        }];
    }
    return self;
}

- (void)updateSummaryCell:(HWSummaryMonthModel *)summaryMonth {
    self.lblBank.text = summaryMonth.typeName;

    self.barChart.yValues = summaryMonth.yValues;
    [self.barChart strokeChart];
//    if (!summaryMonth.hasStroke) {
//
//        summaryMonth.hasStroke = YES;
//    }
    self.barChart.xLabels = summaryMonth.xLabels;
    for (PNBar *bar in self.barChart.bars) {
        bar.textLayer.fontSize = 12;
    }


}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - PNChartDelegate

- (void)userClickedOnBarAtIndex:(NSInteger)barIndex {
    if (self.delegate && [self.delegate respondsToSelector:@selector(yearSummaryCell:didTapBarAtIndex:)]) {
        [self.delegate yearSummaryCell:self didTapBarAtIndex:barIndex];
    }
}


#pragma mark - Getter

- (PNBarChart *)barChart {
    if (!_barChart) {
        _barChart = [[PNBarChart alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 40, 220)];
        _barChart.barWidth = 32;
        _barChart.isShowNumbers = YES;
        _barChart.labelFont = [UIFont systemFontOfSize:10];
        _barChart.chartMarginTop = 5;
        _barChart.chartMarginBottom = 5;
//        _barChart.chartMarginLeft = 22;
        _barChart.barWidth = 42;
        _barChart.delegate = self;
    }
    return _barChart;
}

- (UILabel *)lblBank {
    if (!_lblBank) {
        _lblBank = [UILabel labelWithAlignment:NSTextAlignmentCenter textColor:[UIColor darkTextColor] font:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]];
    }
    return _lblBank;
}


@end
