//
//  ABCDeliveryCompleteMap.m
//  your-dpd
//
//  Created by Richard Simkins on 21/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryCompleteMap.h"

#import "AppDelegate.h"

@interface ABCDeliveryCompleteMap()
@end

@implementation ABCDeliveryCompleteMap
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
