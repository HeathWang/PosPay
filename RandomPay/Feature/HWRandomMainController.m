//
//  HWRandomMainController.m
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWRandomMainController.h"
#import "HWRandomView.h"

@interface HWRandomMainController ()

@property (nonatomic, strong) HWRandomView *randomView;

@end

@implementation HWRandomMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupView];
}

- (void)setupNav {
    self.navigationItem.title = @"RANDOM";
}

- (void)setupView {
    [self.view addSubview:self.randomView];
    [self.randomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@64);
    }];
}

#pragma mark - Getter

- (HWRandomView *)randomView {
    if (!_randomView) {
        _randomView = [[HWRandomView alloc] initWithFrame:CGRectZero];
    }
    return _randomView;
}


@end
