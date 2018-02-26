//
//  HWTypeSelectView.m
//  RandomPay
//
//  Created by Heath on 26/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWTypeSelectView.h"
#import "HWPosTypeCollectionCell.h"

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
        _selectIndex = 2;

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

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndex = indexPath.row;
    [collectionView reloadData];
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
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        flowLayout.itemSize = CGSizeMake(60, 40);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];


        [HWPosTypeCollectionCell registerIn:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}


@end
