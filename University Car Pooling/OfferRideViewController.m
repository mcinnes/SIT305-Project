//
//  OfferRideViewController.m
//  University Car Pooling
//
//  Created by Stewart Fullard on 4/05/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import "OfferRideViewController.h"

@interface OfferRideViewController ()

@end

@implementation OfferRideViewController{
    
    -(IBAction)save:(id)sender {
        
        // Save Latitude Longtitude String
        NSString *saveString = latitude_Longtitude.text;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:saveString forKey:@"saveString"];
        [defaults synchronize];
        
        // Save Location Description String
        NSString *saveString1 = LocationDescription.text;
        NSUserDefaults *defaults1 = [NSUserDefaults standardUserDefaults];
        [defaults1 setObject:saveString1 forKey:@"saveString1"];
        [defaults1 synchronize];
        
        // Save Location String
        NSString *saveString2 = Location.text;
        NSUserDefaults *defaults2 = [NSUserDefaults standardUserDefaults];
        [defaults2 setObject:saveString2 forKey:@"saveString2"];
        [defaults2 synchronize];
        
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
