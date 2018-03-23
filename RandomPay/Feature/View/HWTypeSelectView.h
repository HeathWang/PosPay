//
//  HWTypeSelectView.h
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HWTypeSelectViewDelegate <NSObject>

- (void)didSelectedAtIndex:(NSInteger)index inCell:(UITableViewCell *)cell;

@end


@interface HWTypeSelectView : UIView

@property (nonatomic, assign, readonly) NSInteger selectIndex;
@property (nonatomic, weak) id <HWTypeSelectViewDelegate> delegate;

- (instancetype)initWithTypeList:(NSArray *)typeList;

- (void)changeSelectIndex:(NSInteger)index;

- (void)setDataSource:(NSArray *)list;

+ (instancetype)viewWithTypeList:(NSArray *)typeList;


@end
