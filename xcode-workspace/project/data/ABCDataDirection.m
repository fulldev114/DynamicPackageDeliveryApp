//
//  ABCDataDirection.m
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDataDirection.h"

@interface ABCDataDirection()
@end

@implementation ABCDataDirection
	- (instancetype) initWithNSDictionary:(NSDictionary *)dictionary {
		self = [super init];

		if (!self) return nil;

		if ([self validValueInDictionary:dictionary forKey:@"directions"]) {
			[self setDirections:[dictionary objectForKey:@"directions"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"distance"]) {
			[self setDistance:[NSNumber numberWithUnsignedInteger:[[dictionary objectForKey:@"distance"] unsignedIntegerValue]]];
		}

		return self;
	}
@end
