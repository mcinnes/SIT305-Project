//
//  ViewController.m
//  University Car Pooling
//
//  Created by Matt McInnes on 14/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import "ViewController.h"
#import "OnboardingViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLLocationManager *locationManager;
    locationManager = [[CLLocationManager alloc] init];
    
    OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"Page Title" body:@"Page body goes here." image:[UIImage imageNamed:@"icon"] buttonText:@"Next" action:^{
        // do something here when users press the button, like ask for location services permissions, register for push notifications, connect to social media, or finish the onboarding process
    }];
    
    OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"Allow Location Services" body:@"We use location services to show your location during a ride, and when finding rides." image:[UIImage imageNamed:@"icon"] buttonText:@"Allow Location Services" action:^{
        
        [locationManager requestWhenInUseAuthorization];
        secondPage.movesToNextViewController = YES;

    }];
    
    OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"Allow Push Notifications" body:@"We use push notifications to alert you when a ride has been found." image:[UIImage imageNamed:@"icon"] buttonText:@"Allow Push Notifications" action:^{
        
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];

        
    }];
    
    OnboardingContentViewController *fourthPage = [OnboardingContentViewController contentWithTitle:@"Thank You" body:@"You are now ready to use the app" image:[UIImage imageNamed:@"icon"] buttonText:@"Finish" action:^{
        
        [self handleOnboardingCompletion];
        
    }];

    
    OnboardingViewController *onboardingVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"street"] contents:@[firstPage, secondPage, thirdPage, fourthPage]];
    onboardingVC.shouldFadeTransitions = YES;
    onboardingVC.fadePageControlOnLastPage = YES;
    onboardingVC.fadeSkipButtonOnLastPage = YES;
    onboardingVC.allowSkipping = YES;
    onboardingVC.skipHandler = ^{
        [self handleOnboardingCompletion];
    };
    
    [self presentViewController:onboardingVC animated:YES completion:nil];
    

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)handleOnboardingCompletion {
    // set that we have completed onboarding so we only do it once... for demo
    // purposes we don't want to have to set this every time so I'll just leave
    // this here...
    //    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kUserHasOnboardedKey];
    
    // transition to the main application
    [self dismissViewControllerAnimated:true completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
