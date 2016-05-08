//
//  LocationService.h
//  University Car Pooling
//
//  Created by Matt McInnes on 23/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface LocationService : NSObject <CLLocationManagerDelegate>

+(LocationService *) sharedInstance;

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *currentLocation;

@property (nonatomic, strong, readonly) NSMutableArray *routeLocations;

@property (nonatomic, strong, readonly) MKPolyline *routePolyline;

@property (nonatomic, readonly) MKCoordinateRegion routeRegion;

// Coordinates
//
@property (nonatomic) CLLocationDegrees minimumLatitude;
@property (nonatomic) CLLocationDegrees maximumLatitude;
@property (nonatomic) CLLocationDegrees minimumLongitude;
@property (nonatomic) CLLocationDegrees maximumLongitude;


- (void)startUpdatingLocation;
- (void)requestUse;
-(CLLocation *)getCurrentLocation;

@end
