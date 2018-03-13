//
//  ABCDataParcelLocation.m
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDataParcelLocation.h"

@interface ABCDataParcelLocation()
@end

@implementation ABCDataParcelLocation
	- (instancetype) initWithNSDictionary:(NSDictionary *)dictionary {
		self = [super init];

		if (!self) return nil;

		if ([self validValueInDictionary:dictionary forKey:@"date"]) {
			[self setEventDate:[dictionary objectForKey:@"date"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"event_description"]) {
			[self setEventDescription:[dictionary objectForKey:@"event_description"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"place_name"]) {
			[self setPlaceName:[dictionary objectForKey:@"place_name"]];
		}

		return self;
	}
@end
