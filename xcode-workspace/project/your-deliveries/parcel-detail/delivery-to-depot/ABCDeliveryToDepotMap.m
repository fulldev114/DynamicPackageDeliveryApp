//
//  ABCDeliveryToDepotMap.m
//  your-dpd
//
//  Created by Richard Simkins on 19/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryToDepotMap.h"

#import "AppDelegate.h"

@interface ABCDeliveryToDepotMap()
@end

@implementation ABCDeliveryToDepotMap
	- (instancetype) init {

		self = [super init];

		if (!self) return nil;

		[self setBackgroundColor:[UIColor yellowColor]];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			265.0f)];

		return self;
	}
@end
