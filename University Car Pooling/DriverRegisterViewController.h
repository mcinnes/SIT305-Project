//
//  DriverRegisterViewController.h
//  University Car Pooling
//
//  Created by Stewart Fullard on 30/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverRegisterViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *CarColour;
@property (nonatomic, strong) IBOutlet UITextField *CarType;
@property (nonatomic, strong) IBOutlet UITextField *NumberPlate;
@property (nonatomic, strong) IBOutlet UITextField *LicenseNumber;
@property (nonatomic, strong) IBOutlet UISwitch *Coffee;

@end
