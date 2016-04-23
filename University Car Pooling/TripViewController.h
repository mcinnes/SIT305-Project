//
//  TripViewController.h
//  University Car Pooling
//
//  Created by Matt McInnes on 18/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Tracker.h"
@interface TripViewController : UIViewController <TrackerDelegate, MKMapViewDelegate> {

}

@property (nonatomic, strong) MKMapView *mapView;

@property (nonatomic, strong) Tracker *tracker;


@end
