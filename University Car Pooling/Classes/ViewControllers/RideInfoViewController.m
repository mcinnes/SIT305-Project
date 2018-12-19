//
//  RideInfoViewController.m
//  University Car Pooling
//
//  Created by Matt McInnes on 26/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import "RideInfoViewController.h"

@interface RideInfoViewController ()

@end

@implementation RideInfoViewController
@synthesize ride;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _destinationLabel.text = ride[@"destinationDescription"];
    _meetingLabel.text = ride[@"location"];
    
    //MapView
    PFGeoPoint *tempGeo = ride[@"destination"];
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(tempGeo.latitude, tempGeo.longitude);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(0.1, 0.1);
    MKCoordinateRegion region = {coord, span};
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coord];
    
    [self.mapView setRegion:region];
    [self.mapView addAnnotation:annotation];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)acceptRide:(id)sender {
    
    ride[@"accepted"] = @"Yes";
    ride[@"acceptedBy"] = [[PFUser currentUser]objectId];
    [ride saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self getDriverDetails];
        } else {
            // There was a problem, check error.description
            NSLog(@"%@", error);
        }
    }];
    
}

//FIX

-(void)getDriverDetails{
    
    PFQuery *query = [PFUser query];
    [query whereKey:@"objectId" equalTo:ride[@"userID"]];
    PFUser *driver = [query getFirstObject];
    NSLog(@"Driver %@", driver);

    _driverNameLabel.text = driver[@"Name"];
    
    NSLog(@"DriverID %@", driver[@"driverID"]);

    PFQuery *driverDetailsQuery = [PFQuery queryWithClassName:@"Driver"];
    [query whereKey:@"objectId" equalTo:driver[@"driverID"]];
    PFObject *driverDetails = [driverDetailsQuery getFirstObject];
    NSLog(@"Driver2 %@", driverDetails);

    _carNumberPlateLabel.text = driverDetails[@"licensePlate"];
    _carTypeLabel.text = driverDetails[@"carType"];
    
}

@end
