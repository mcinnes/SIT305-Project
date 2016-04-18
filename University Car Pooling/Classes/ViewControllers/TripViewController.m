//
//  TripViewController.m
//  University Car Pooling
//
//  Created by Matt McInnes on 18/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import "TripViewController.h"

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface TripViewController ()

@end

@implementation TripViewController
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self locationSetup];
    [self mapSetup];
    // Do any additional setup after loading the view.
}
-(void)mapSetup{
    
    mapView.delegate = self;
    mapView.showsUserLocation = YES;
    mapView.mapType = MKMapTypeSatellite;
    
    CLLocation *location = [locationManager location];
    
    MKCoordinateRegion mapRegion;
    mapRegion.center = location.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    
    [mapView setRegion:mapRegion animated: YES];

}
-(void)locationSetup{
    locationManager = [[CLLocationManager alloc] init];
    
    #ifdef __IPHONE_8_0
        if(IS_OS_8_OR_LATER) {
            [locationManager requestWhenInUseAuthorization];
            //[locationManager requestAlwaysAuthorization];
        }
    #endif
    
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    //NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fuck{
    CLLocation *location = [locationManager location];

    NSMutableArray *pointsOnRoute;
    pointsOnRoute = [[NSMutableArray alloc] init];
    
    
    int spanX = 0.007;
    int spanY = 0.007;
    MKCoordinateRegion newRegion = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(spanX, spanY));
    
    CLLocationCoordinate2D coord[2];
    coord[0].latitude = 45.42207;
    coord[0].longitude = 9.123888;
    coord[1].latitude = 45.422785;
    coord[1].longitude = 9.12377;
    
    MKPolyline *polyline = [[MKPolyline alloc] init];
    polyline = [MKPolyline polylineWithCoordinates:coord count:2];
    
    
    
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id <MKOverlay>)overlay {
    MKPolyline *polyline = [[MKPolyline alloc] init];

    MKPolylineView *polyLineView = [[MKPolylineView alloc] initWithPolyline:polyline];
    polyLineView.fillColor = [UIColor blueColor];
    polyLineView.strokeColor = [UIColor greenColor];
    polyLineView.lineWidth = 7;
    return polyLineView;
}


@end
