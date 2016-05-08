//
//  RequestRideViewController.h
//  University Car Pooling
//
//  Created by Stewart Fullard on 4/05/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LocationService.h"
@interface RequestRideViewController : UIViewController{
    
    IBOutlet UITextField *latitude_Longtitude;
    IBOutlet UITextField *LocationDescription;
    IBOutlet UITextField *Location;
    
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

-(IBAction)save:(id)sender;
@property (nonatomic, strong) LocationService *locationService;

@end
