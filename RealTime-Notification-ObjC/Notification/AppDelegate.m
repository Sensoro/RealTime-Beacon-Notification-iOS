//
//  AppDelegate.m
//  Notification
//
//  Created by David Yang on 15/2/28.
//  Copyright (c) 2015年 Sensoro. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreLocation/CoreLocation.h>

@interface AppDelegate () <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocationManager  *locationManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        // request authorization to track the user’s location
        [_locationManager requestAlwaysAuthorization];

        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }else{
#ifndef __IPHONE_8_0
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
#endif//__IPHONE_8
    }
    
    
    CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:[[NSUUID alloc] initWithUUIDString:@"23A01AF0-232A-4518-9C0E-323FB773F5EF"] major:0x8888 minor:0x8888
                                                                identifier:@"SensoroTest"];
    region.notifyOnEntry = YES;
    region.notifyOnExit = YES;
    
    [_locationManager startMonitoringForRegion:region];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}

- (void)scheduleLocalNotificationTips:(NSString *)tips{
    
    NSString * message = [NSString stringWithFormat:@"%@Sensoro-ObjC",tips];
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = message;

    notification.applicationIconBadgeNumber = [[UIApplication sharedApplication] applicationIconBadgeNumber] + 1;
    notification.soundName = UILocalNotificationDefaultSoundName;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];

}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSLog(@"本地通知 %@",notification.alertBody);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    [self scheduleLocalNotificationTips:@"欢迎进入"];
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    [self scheduleLocalNotificationTips:@"谢谢光临"];
}

- (void)locationManager:(CLLocationManager *)manager
didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        NSLog(@"已获得授权！");
    }
}


@end
