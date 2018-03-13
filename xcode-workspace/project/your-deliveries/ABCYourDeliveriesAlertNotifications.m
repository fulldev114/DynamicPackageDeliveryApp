//
//  ABCYourDeliveriesAlertNotifications.m
//  your-dpd
//
//  Created by Richard Simkins on 08/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourDeliveriesAlertNotifications.h"

#import "AppDelegate.h"

@interface ABCYourDeliveriesAlertNotifications()
@end

@implementation ABCYourDeliveriesAlertNotifications
	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setSelector:@selector(tap)];
		[self setText:NSLocalizedString(@"To get the most from this app, please enable notifications in your settings.", nil)];
		[self initialise];

		return self;
	}

	- (void) tap {
		NSLog(@"Tap your deliveries alert notifications.");
	}
@end
