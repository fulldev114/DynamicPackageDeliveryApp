//
//  ABCDataShop.m
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDataShop.h"

@interface ABCDataShop()
@end

@implementation ABCDataShop
	- (instancetype) initWithNSDictionary:(NSDictionary *)dictionary {
		self = [super init];

		if (!self) return nil;

		if ([self validValueInDictionary:dictionary forKey:@"address_single_line"]) {
			[self setAddressSingleLine:[dictionary objectForKey:@"address_single_line"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"distance_miles"]) {
			[self setDistanceMiles:[dictionary objectForKey:@"distance_miles"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"place_name"]) {
			[self setPlaceName:[dictionary objectForKey:@"place_name"]];
		}

		return self;
	}
@end
