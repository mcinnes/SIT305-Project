//
//  OfferRideViewController.h
//  University Car Pooling
//
//  Created by Stewart Fullard on 4/05/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferRideViewController : UIViewController{

    IBOutlet UITextField *latitude_Longtitude;
    IBOutlet UITextField *LocationDescription;
    IBOutlet UITextField *Location;
}


-(IBAction)save:(id)sender;
@end
