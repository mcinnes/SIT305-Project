//
//  LocationService.m
//  University Car Pooling
//
//  Created by Matt McInnes on 23/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import "LocationService.h"

@interface LocationService () <CLLocationManagerDelegate>



@end

@implementation LocationService

+(LocationService *) sharedInstance
{
    static LocationService *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

- (id)init {
    self = [super init];
    if(self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        self.locationManager.distanceFilter = 100; // meters
        self.locationManager.activityType = CLActivityTypeAutomotiveNavigation;
        self.locationManager.delegate = self;
    }
    return self;
}
-(void)requestUse{
    [self.locationManager requestWhenInUseAuthorization];
}

-(void)beginTracking{
    
}
- (void)startUpdatingLocation
{
    NSLog(@"Starting location updates");
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Location service failed with error %@", error);
}



#pragma mark
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [self.routeLocations addObjectsFromArray:locations];
    
    for (CLLocation *location in locations) {
        [self handleLocationUpdate:location];
    }
}
- (void)handleLocationUpdate:(CLLocation *)location {
    // Coordinates
    //
    CLLocationCoordinate2D coord = location.coordinate;
    CLLocationDegrees latitude = coord.latitude;
    CLLocationDegrees longitude = coord.longitude;
    
    if (latitude > self.maximumLatitude) {
        self.maximumLatitude = latitude;
    }
    
    if (latitude < self.minimumLatitude) {
        self.minimumLatitude = latitude;
    }
    
    if (longitude < self.minimumLongitude) {
        self.minimumLongitude = longitude;
    }
    
    if (longitude > self.maximumLongitude) {
        self.maximumLongitude = longitude;
    }
    
}


@end
