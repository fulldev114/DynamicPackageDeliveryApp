//
//  ABCDeliveryTodayMap.m
//  your-dpd
//
//  Created by Richard Simkins on 11/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryTodayMap.h"

#import "AppDelegate.h"

@interface ABCDeliveryTodayMap()
@end

@implementation ABCDeliveryTodayMap
	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			265.0f)];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setBackgroundColor:[UIColor yellowColor]];
	}
@end
