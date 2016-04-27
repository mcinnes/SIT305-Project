//
//  Annotation.h
//  University Car Pooling
//
//  Created by Matt McInnes on 27/04/2016.
//  Copyright © 2016 Matt McInnes. All rights reserved.
//

#import <Foundation/Foundation.h>

@implementation Annotation

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    [self setTitle:nil];
    [self setSubtitle:nil];
    
}



@end