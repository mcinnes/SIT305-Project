//
//  RideInfoViewController.m
//  University Car Pooling
//
//  Created by Matt McInnes on 26/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

/*#import "RideInfoViewController.h"

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
    
    CLLocationCoordinate2D annotationCoordinate = CLLocationCoordinate2DMake(tempGeo.latitude, tempGeo.longitude);
    MapAnnotation *annotation = [[MapAnnotation alloc] init];
    annotation.coordinate = annotationCoordinate;
    //        annotation.title = location[@"Name"];
    //        annotation.subtitle = location[@"Place"];
    [self.mapView addAnnotation:annotation];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)acceptRide:(id)sender {
    
}


@end*/
