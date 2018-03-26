//
//  HWTypeSelectView.m
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWTypeSelectView.h"
#import "HWPosTypeCollectionCell.h"
#import "UIView+HWAdd.h"

@interface HWTypeSelectView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, copy) NSArray *typeList;

@end

@implementation HWTypeSelectView


- (instancetype)initWithTypeList:(NSArray *)typeList {
    self = [super init];
    if (self) {
        _typeList = [typeList copy];

        [self addSubview:self.collectionView];

        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
    }
    return self;
}

+ (instancetype)viewWithTypeList:(NSArray *)typeList {
    return [[self alloc] initWithTypeList:typeList];
}

- (void)setDataSource:(NSArray *)list selected:(NSInteger)index {
    self.selectIndex = index;
    self.typeList = list;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndex = indexPath.row;
    [collectionView reloadData];

    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedAtIndex:inCell:)]) {

        [self.delegate didSelectedAtIndex:indexPath.row inCell:self.tableViewCell];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.typeList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HWPosTypeCollectionCell *collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:[HWPosTypeCollectionCell identifier] forIndexPath:indexPath];

    [collectionCell updateButtonText:self.typeList[(NSUInteger) indexPath.row] isSelected:indexPath.row == self.selectIndex];
    return collectionCell;
}


#pragma mark - Getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 8;
        CGFloat itemWidth = (ScreenWidth - 14 * 2 - 8 * 3) / 4;
        flowLayout.itemSize = CGSizeMake(itemWidth, IPHONEPLUS(40));

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(14, 14, 0, 14);

        [HWPosTypeCollectionCell registerIn:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

#pragma mark - Setter

- (void)setScrollDirection:(UICollectionViewScrollDirection)scrollDirection {
    _scrollDirection = scrollDirection;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *) self.collectionView.collectionViewLayout;
    flowLayout.scrollDirection = scrollDirection;
    self.collectionView.collectionViewLayout = flowLayout;
    if (scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        self.collectionView.contentInset = UIEdgeInsetsZero;
    }
}


@end
