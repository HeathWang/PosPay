//
//  HWSummaryController.m
//  RandomPay
//
//  Created by Heath on 01/02/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "HWSummaryController.h"
#import "RLMRealm.h"
#import "HWRandom.h"

@interface HWSummaryController ()

@property (nonatomic, copy) NSNumber *total;
@property (nonatomic, copy) NSNumber *cost;

@end

@implementation HWSummaryController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"SUMMARY";
    [self setupData];
}

- (void)setupData {
//    RLMRealm *realm = [RLMRealm defaultRealm];
    self.total = [[HWRandom allObjects] sumOfProperty:@"value"];
    NSNumber *total_38 = [[HWRandom objectsWhere:@"costPercent == 0.0038"] sumOfProperty:@"value"];
    NSNumber *total_60 = [[HWRandom objectsWhere:@"costPercent == 0.0060"] sumOfProperty:@"value"];
    NSNumber *total_100 = [[HWRandom objectsWhere:@"costPercent == 0.0100"] sumOfProperty:@"value"];
    self.cost = @(total_38.floatValue * 0.0038 + total_60.floatValue * 0.0060 + total_100.floatValue * 0.0100);

//    NSLog(@"# %@ %@ %@", total_38, total_60, total_100);
    NSLog(@"# %@ %@", self.total, self.cost);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
