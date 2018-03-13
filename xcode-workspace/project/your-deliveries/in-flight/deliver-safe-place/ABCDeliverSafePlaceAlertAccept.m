//
//  ABCDeliverSafePlaceAlertAccept.m
//  your-dpd
//
//  Created by Richard Simkins on 26/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliverSafePlaceAlertAccept.h"

#import "AppDelegate.h"
#import "ABCAlertArrow.h"

@interface ABCDeliverSafePlaceAlertAccept()
@end

@implementation ABCDeliverSafePlaceAlertAccept
	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setText:NSLocalizedString(@"We cannot deliver to a safe place unless you accept responsibility", nil)];
		[self initialise];

		ABCAlertArrow* arrow = [[ABCAlertArrow alloc] init];
		[self addSubview:arrow];
		[arrow setPosition:CGPointMake(
			[AppDelegate SizePaddingFromSides] * 2.0f,
			0.0f)];

		return self;
	}
@end
