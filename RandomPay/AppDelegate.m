//
//  AppDelegate.m
//  RandomPay
//
//  Created by Heath on 22/01/2018.
//  Copyright © 2018 heathwang. All rights reserved.
//

#import "AppDelegate.h"
#import "HWBaseNavigationController.h"
#import "HWRandomMainController.h"
#import "IQKeyboardManager.h"
#import "RLMRealmConfiguration.h"
#import "RLMMigration.h"
#import "HWRandom.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self configRLMDatabase];
    [self initWindow];
    [self configKeyboardManager];
    [self configGlobalUI];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - init & config

- (void)initWindow {
    UIWindow *window1 = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    HWRandomMainController *mainController = [HWRandomMainController new];
    HWBaseNavigationController *rootNav = [[HWBaseNavigationController alloc] initWithRootViewController:mainController];
    rootNav.hideLine = NO;

    window1.rootViewController = rootNav;
    self.window = window1;
    [self.window makeKeyAndVisible];
}

- (void)configKeyboardManager {
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
}

- (void)configRLMDatabase {

    NSLog(@">>> %@", [RLMRealmConfiguration defaultConfiguration].fileURL);
    RLMRealmConfiguration *configuration = [RLMRealmConfiguration defaultConfiguration];
    uint64_t version = 3;
    configuration.schemaVersion = version;
    configuration.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < version) {
            // do some action.
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:configuration];
    [RLMRealm defaultRealm];

    // version3 新增posType，默认设置为1
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    RLMResults *randoms = [HWRandom objectsInRealm:realm where:@"posType = null"];
    [randoms setValue:@(1) forKeyPath:@"posType"];
    [realm commitWriteTransaction];
}

- (void)configGlobalUI {
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    barButtonItem.tintColor = kThemeColor;

    [UITextField appearance].tintColor = kThemeColor;
    [UISwitch appearance].tintColor = kThemeColor;
    [UISlider appearance].tintColor = kThemeColor;
}


@end
