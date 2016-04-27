//
//  Annotation.m
//  University Car Pooling
//
//  Created by Matt McInnes on 27/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import "Annotation.h"
#import <MapKit/MapKit.h>

@interface Annotation : NSObject <MKAnnotation> {
    NSString *_title;
    NSString *_subtitle;
    
    CLLocationCoordinate2D _coordinate;
}

// Getters and setters
- (void)setTitle:(NSString *)title;
- (void)setSubtitle:(NSString *)subtitle;

@end