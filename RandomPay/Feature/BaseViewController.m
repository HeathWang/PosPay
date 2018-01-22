//
//  BaseViewController.m
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)loadView {
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor whiteColor];
    self.view = view1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setup view

- (void)setupNav {

}

- (void)setupView {

}

- (void)setupData {

}


@end
