//
//  HWTypeSelectCell.m
//  RandomPay
//
//  Created by Heath on 22/03/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWTypeSelectCell.h"
#import "HWTypeSelectView.h"

@interface HWTypeSelectCell ()

@end

@implementation HWTypeSelectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.typeSelectView];

        [self.typeSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }

    return self;
}

- (void)updateCellList:(NSArray *)list {
    [self.typeSelectView setDataSource:list];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)calculateCellHeight:(NSInteger)count {
    NSInteger i = count / 4;
    NSInteger j = count % 4;
    if (j > 0) {
        i ++;
    }

    return IPHONEPLUS(40) * i + 14 * 2 + (i - 1) * 10;
}

#pragma mark - Getter

- (HWTypeSelectView *)typeSelectView {
    if (!_typeSelectView) {
        _typeSelectView = [HWTypeSelectView viewWithTypeList:nil];
    }
    return _typeSelectView;
}


@end
