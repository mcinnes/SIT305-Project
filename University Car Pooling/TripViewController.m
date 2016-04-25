//
//  TripViewController.m
//  University Car Pooling
//
//  Created by Matt McInnes on 18/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import "TripViewController.h"
static CGFloat const kRegionPaddingMultiplier = 1.33;


@interface TripViewController ()

@end

@implementation TripViewController
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.locationService = [LocationService new];
    
    [self.mapView addOverlay:self.routePolyline];
    [self.mapView setRegion:self.routeRegion animated:YES];
    
}

#pragma mark - Map view delegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.fillColor = [UIColor colorWithRed:250/255.0 green:90/255.0 blue:45/255.0 alpha:1.0];
    renderer.strokeColor = [UIColor colorWithRed:250/255.0 green:90/255.0 blue:45/255.0 alpha:1.0];
    renderer.lineWidth = 5;
    return renderer;
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
        [self.mapView setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(.0005, .0005)) animated:YES];
}

- (void)createRegionForRoute {
    CLLocationCoordinate2D centerCoordinate = CLLocationCoordinate2DMake((self.locationService.minimumLatitude + self.locationService.maximumLatitude) / 2.0, (self.locationService.minimumLongitude + self.locationService.maximumLongitude) / 2.0);
    MKCoordinateSpan span = MKCoordinateSpanMake((self.locationService.maximumLatitude - self.locationService.minimumLatitude) * kRegionPaddingMultiplier, (self.locationService.maximumLongitude - self.locationService.minimumLongitude) * kRegionPaddingMultiplier);
    
    _routeRegion = MKCoordinateRegionMake(centerCoordinate, span);
}

- (void)createPolylineForRoute {
    NSUInteger locationsCount = self.locationService.routeLocations.count;
    CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * locationsCount);
    
    for (NSUInteger i = 0; i < locationsCount; i++) {
        CLLocation *location = self.routeLocations[i];
        coords[i] = location.coordinate;
    }
    
    _routePolyline = [MKPolyline polylineWithCoordinates:coords count:locationsCount];
}

@end
