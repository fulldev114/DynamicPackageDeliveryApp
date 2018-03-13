//
//  ABCParcelDetailAlertLocation.m
//  your-dpd
//
//  Created by Richard Simkins on 11/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCParcelDetailAlertLocation.h"

#import "AppDelegate.h"
#import "ABCAlertArrow.h"

@interface ABCParcelDetailAlertLocation()
@end

@implementation ABCParcelDetailAlertLocation
	- (instancetype) initWithArrowPosition:(CGFloat)arrowPosition {
		self = [super init];

		if (!self) return nil;

		[self setSelector:@selector(tap)];
		[self setText:NSLocalizedString(@"Enable your location sharing settings", nil)];
		[self initialise];

		// o The left padding of this view is thicker than the left padding of the map key view
		//   where the position is derived from.
		CGFloat correction = [AppDelegate SizePaddingFromSides] - [AppDelegate SizePaddingFromSidesThin];
		ABCAlertArrow* arrow = [[ABCAlertArrow alloc] init];
		[self addSubview:arrow];
		[arrow setPosition:CGPointMake(
			arrowPosition - correction,
			0.0f)];

		return self;
	}

	- (void) tap {
		NSLog(@"Tap your deliveries parcel detail alert location.");
	}
@end
