//
//  TripViewController.m
//  University Car Pooling
//
//  Created by Matt McInnes on 18/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import "TripViewController.h"


@interface TripViewController ()

@end

@implementation TripViewController
@synthesize mapView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tracker = [Tracker new];
//self.tracker.de
    // Do any additional setup after loading the view.
}


@end
