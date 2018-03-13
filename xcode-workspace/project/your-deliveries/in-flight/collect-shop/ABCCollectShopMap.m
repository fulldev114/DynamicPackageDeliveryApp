//
//  ABCCollectShopMap.m
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCCollectShopMap.h"

#import "AppDelegate.h"

@interface ABCCollectShopMap()
@end

@implementation ABCCollectShopMap
	- (instancetype) init {

		self = [super init];

		if (!self) return nil;

		[self setBackgroundColor:[UIColor yellowColor]];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width,
			265.0f)];

		return self;
	}
@end
