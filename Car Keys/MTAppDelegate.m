//
//  MTAppDelegate.m
//  Car Keys
//
//  Created by Martijn The on 5/25/14.
//  Copyright (c) 2014 Martijn Thé. All rights reserved.
//

#import "MTCarKeyiBeaconMonitor.h"
#import "MTViewController.h"

#import "MTAppDelegate.h"

@interface MTAppDelegate ()
@property MTCarKeyiBeaconMonitor *monitor;
@property MTViewController *mainViewController;
@end

@implementation MTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] init];

  self.monitor = [[MTCarKeyiBeaconMonitor alloc] init];

  self.mainViewController = [[MTViewController alloc] initWithMonitor:self.monitor];
  self.window.rootViewController = self.mainViewController;
  [self.window makeKeyAndVisible];
  return YES;
}

@end
