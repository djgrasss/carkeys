//
//  MTCarKeyiBeaconMonitor.m
//  Car Keys
//
//  Created by Martijn The on 5/25/14.
//  Copyright (c) 2014 Martijn Thé. All rights reserved.
//

@import CoreLocation;

#import "MTCarKeyiBeaconMonitor.h"

static NSString * const MTCarKeyiBeaconUUIDString = @"2EC88E2C-4EF2-4E77-BF13-5C3470DAF038";

@interface MTCarKeyiBeaconMonitor () <CLLocationManagerDelegate>
@property CLLocationManager *locationManager;
@property CLBeaconRegion *region;
@property (readwrite) double distance;
@end

@implementation MTCarKeyiBeaconMonitor

- (instancetype)init {
  self = [super init];
  if (self) {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;

    NSUUID *uuid = [[NSUUID alloc] initWithUUIDString:MTCarKeyiBeaconUUIDString];
    self.region = [[CLBeaconRegion alloc] initWithProximityUUID:uuid identifier:MTCarKeyiBeaconUUIDString];
    [self.locationManager startRangingBeaconsInRegion:self.region];

    self.locationManager.delegate = self;
  }
  return self;
}

- (void)dealloc {
  [self.locationManager stopRangingBeaconsInRegion:self.region];
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region {
  if (![region isEqual:self.region]) {
    return;
  }
  if ([beacons count] < 1) {
    self.distance = DBL_MAX;
    return;
  }
  CLBeacon *beacon = beacons[0];
  const double distance = beacon.accuracy;
  if (distance < 0.0) {
    self.distance = DBL_MAX;
    return;
  }
  self.distance = distance;
}

@end
