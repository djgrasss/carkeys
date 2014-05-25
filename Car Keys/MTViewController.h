//
//  MTViewController.h
//  Car Keys
//
//  Created by Martijn The on 5/25/14.
//  Copyright (c) 2014 Martijn Thé. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MTCarKeyiBeaconMonitor.h"

@interface MTViewController : UIViewController
@property (readonly) MTCarKeyiBeaconMonitor *monitor;
- (id)initWithMonitor:(MTCarKeyiBeaconMonitor *)monitor;
@end
