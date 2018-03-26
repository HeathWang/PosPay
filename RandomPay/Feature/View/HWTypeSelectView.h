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
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

- (instancetype)initWithTypeList:(NSArray *)typeList;

- (void)setDataSource:(NSArray *)list selected:(NSInteger)index;

+ (instancetype)viewWithTypeList:(NSArray *)typeList;

@end
