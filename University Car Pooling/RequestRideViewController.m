//
//  RequestRideViewController.m
//  University Car Pooling
//
//  Created by Stewart Fullard on 4/05/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import "RequestRideViewController.h"
#import "LocationService.h"
#import <Parse/Parse.h>
@interface RequestRideViewController () {
    NSString *locationString;
    CLLocationCoordinate2D locCoord;
    NSArray *uniLocations;
    NSArray *uniNames;
}
//Add auto Location thing
//Add going to by pin drop
//
//
//
//



@end

@implementation RequestRideViewController

-(IBAction)save:(id)sender {
    
    PFGeoPoint *locationPoint = [PFGeoPoint geoPointWithLatitude:locCoord.latitude longitude:locCoord.longitude];
    
    PFObject *ride = [PFObject objectWithClassName:@"GameScore"];
    ride[@"location"] = locationPoint;
    ride[@"destinationDescription"] = LocationDescription.text;
    ride[@"location"] = Location.text;
    [ride saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }];
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.mapView addGestureRecognizer:longPressGesture];
    
    uniNames = @[@"Deakin", @"Monash", @"Swinburn"];
    CLLocation *deakin = [[CLLocation alloc]  initWithLatitude:-37.914002 longitude:145.2653463];
    uniLocations = @[deakin];

    self.locationService = [LocationService new];
    
   // Location.text = [self currentLocationDescription:self.locationService.getCurrentLocation];
    
    
    // Do any additional setup after loading the view.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(.0005, .0005)) animated:YES];
}

-(void)handleLongPressGesture:(UIGestureRecognizer*)sender {
    // This is important if you only want to receive one tap and hold event
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self.mapView removeGestureRecognizer:sender];
    }
    else
    {
        // Here we get the CGPoint for the touch and convert it to latitude and longitude coordinates to display on the map
        CGPoint point = [sender locationInView:self.mapView];
       locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        // Then all you have to do is create the annotation and add it to the map
       // YourAnnotation *dropPin = [[YourAnnotation alloc] init];
        //dropPin.latitude = [NSNumber numberWithDouble:locCoord.latitude];
        //dropPin.longitude = [NSNumber numberWithDouble:locCoord.longitude];
        //[self.mapView addAnnotation:dropPin];
       locationString=[[NSString alloc] initWithFormat:@"%f,%f",locCoord.latitude,locCoord.longitude];
        NSLog(@"%@",locationString);
        latitude_Longtitude.text = locationString;
        //NSLog(@"%@", locCoord);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)currentLocationDescription:(CLLocation*)location {
    
    NSString *result = nil;

    for (CLLocation *location in uniLocations) {
        if ([location distanceFromLocation:location] < 3) {
            result = uniLocations[0];
            break;
        }
    }
    
    return result;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
