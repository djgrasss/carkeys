//
//  MTViewController.m
//  Car Keys
//
//  Created by Martijn The on 5/25/14.
//  Copyright (c) 2014 Martijn Thé. All rights reserved.
//

#import "MTViewController.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface MTViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (readwrite) MTCarKeyiBeaconMonitor *monitor;
@end

@implementation MTViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  NSAssert(NO, @"Call -initWithMonitor: pleaze!");
  return nil;
}

- (id)initWithMonitor:(MTCarKeyiBeaconMonitor *)monitor {
  NSParameterAssert(monitor);
  self = [super initWithNibName:nil bundle:nil];
  if (self) {
    self.monitor = monitor;
    [RACObserve(self.monitor, distance) subscribeNext:^(NSNumber *distance) {
      const double distanceDouble = distance.doubleValue;
      [UIView animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        if (distanceDouble != DBL_MAX) {
          self.label.text = [NSString stringWithFormat:@"%0.1f meters", distanceDouble];
          const float farthest = 5.0;
          const float unclippedPercentValue = distanceDouble / farthest;
          const CGFloat red = MIN(MAX(0.f, unclippedPercentValue), 1.f);
          const CGFloat green = 1.f - red;
          self.view.backgroundColor = [UIColor colorWithRed:red
                                                      green:green
                                                       blue:0.f
                                                      alpha:1.f];
        } else {
          self.label.text = [NSString stringWithFormat:@"VERWEGGISTAN!?"];
          self.view.backgroundColor = [UIColor blackColor];
        }
      } completion:nil];
    }];
  }
  return self;
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

@end
