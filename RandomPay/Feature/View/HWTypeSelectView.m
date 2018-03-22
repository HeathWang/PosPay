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

- (void)changeSelectIndex:(NSInteger)index {
    self.selectIndex = index;
    [self.collectionView reloadData];
}

- (void)didMoveToSuperview {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.selectIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    });
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
        flowLayout.minimumInteritemSpacing = 8;
        flowLayout.itemSize = CGSizeMake(80, 40);

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];


        [HWPosTypeCollectionCell registerIn:_collectionView];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}


@end
