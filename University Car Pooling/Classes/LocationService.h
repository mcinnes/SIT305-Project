//
//  LocationService.h
//  University Car Pooling
//
//  Created by Matt McInnes on 23/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationService : NSObject <CLLocationManagerDelegate>

+(LocationService *) sharedInstance;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

- (void)startUpdatingLocation;
- (void)requestUse;

@end
