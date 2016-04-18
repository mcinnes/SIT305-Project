//
//  TripViewController.h
//  University Car Pooling
//
//  Created by Matt McInnes on 18/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface TripViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate> {
    CLLocationManager *locationManager;

}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;


@end
