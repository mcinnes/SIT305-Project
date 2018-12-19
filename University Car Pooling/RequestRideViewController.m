//
//  RequestRideViewController.m
//  University Car Pooling
//
//  Created by Stewart Fullard on 4/05/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import "RequestRideViewController.h"
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
    
    PFObject *ride = [PFObject objectWithClassName:@"currentyLooking"];
    ride[@"location"] = locationPoint;
    ride[@"destinationDescription"] = LocationDescription.text;
    ride[@"location"] = Location.text;
    ride[@"userID"] = [[PFUser currentUser]objectId];
    [ride saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }];
    
    [PFUser currentUser][@"requested"] = @"requested";
    [PFUser currentUser][@"rideID"] = ride.objectId;
    [[PFUser currentUser] saveInBackground];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Your ride has been posted" message:@"Please wait for confirmation" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    //[self viewDidAppear];
    //[self presentViewController:alert animated:YES completion:nil];
    
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)viewDidLoad {
    [super viewDidLoad];
 //   UIBarButtonItem *zoomButton = [[UIBarButtonItem alloc] initWithTitle:@"Zoom" style:UIBa target:self action:@selector(zoom)];
    
    //[self search];
    self.locationService = [LocationService new];

    [self.locationService startUpdatingLocation];
    
    self.mapView.showsUserLocation = true;
    [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];

    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.mapView addGestureRecognizer:longPressGesture];
    
    
    uniNames = @[@"Monash", @"Deakin"];
    
    CLLocation *deakin = [[CLLocation alloc]  initWithLatitude:-37.914002 longitude:145.2653463];
    CLLocation *monash = [[CLLocation alloc]  initWithLatitude:-37.912249 longitude:145.1330203];

    uniLocations = @[monash, deakin];

    
    NSLog(@"UNI %@", [self currentLocationDescription:deakin]);
    
   // Location.text = [self currentLocationDescription:self.locationService.getCurrentLocation];
    
    NSLog(@"%@", self.locationService.getCurrentLocation);
    Location.text = [self currentLocationDescription:self.locationService.getCurrentLocation];
    // Do any additional setup after loading the view.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(.0005, .0005)) animated:YES];
}

-(void)zoom{
    CGRect newFrame = self.mapView.frame;
    
    newFrame.size.width = 200;
    newFrame.size.height = 900;
    [self.mapView setFrame:newFrame];
}


-(void)handleLongPressGesture:(UIGestureRecognizer*)sender {
    // This is important if you only want to receive one tap and hold event
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        //[self.mapView removeGestureRecognizer:sender];
    }
    else
    {
        //Clear previous annotation
        [self.mapView removeAnnotations:self.mapView.annotations];
        
        // Here we get the CGPoint for the touch and convert it to latitude and longitude coordinates to display on the map
        CGPoint point = [sender locationInView:self.mapView];
       locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        // Then all you have to do is create the annotation and add it to the map
       
        MKPointAnnotation *pinPoint = [[MKPointAnnotation alloc] init];
        pinPoint.coordinate = locCoord;
        pinPoint.title = @"Destination";
        [self.mapView addAnnotation:pinPoint];
        
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
-(void)zoomMap{
    //make map full screen
}
- (NSString *)currentLocationDescription:(CLLocation*)location {
    
    NSString __block *result = nil;
   // NSUInteger count = 0;
    
    //for (CLLocation *location in uniLocations) {
        
        //if ([location distanceFromLocation:location] < 3) {
         //   result = uniNames[count];
        //}
        //else {
         //   NSLog(@"Cant find it motherfucker");
       // }
     //   count++;
   // }
    
    [uniLocations
     enumerateObjectsUsingBlock:
     ^(CLLocation *locations, NSUInteger index, BOOL *stop)
     {
         NSLog(@"%@", location);
         if ([locations distanceFromLocation:location] <= 3) {
             NSLog(@"Uninames index%@", uniNames[index]);
             result = uniNames[index];
         }
         else {
             NSLog(@"Cant find uni");
         }     }];
    
    return result;
}

- (IBAction)descriptionSearch:(id)sender {
    NSLog(@"%@", latitude_Longtitude.text);
//if (latitude_Longtitude.text == nil) {
        [self search:LocationDescription.text];
  //  }
}

-(void)search:(NSString *)searchTerm{
    // Create and initialize a search request object.
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchTerm;
    request.region = self.mapView.region;
    
    // Create and initialize a search object.
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    // Start the search and display the results as annotations on the map.
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
    {
        NSMutableArray *placemarks = [NSMutableArray array];
        for (MKMapItem *item in response.mapItems) {
            [placemarks addObject:item.placemark];
        }
        [self.mapView removeAnnotations:[self.mapView annotations]];
        [self.mapView showAnnotations:placemarks animated:NO];
    }];
}

@end
