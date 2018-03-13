//
//  ABCDataTimeslot.m
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDataTimeslot.h"

@interface ABCDataTimeslot()
@end

@implementation ABCDataTimeslot
	- (instancetype) initWithNSDictionary:(NSDictionary *)dictionary {
		self = [super init];

		if (!self) return nil;

		if ([self validValueInDictionary:dictionary forKey:@"timeslot"]) {
			[self setTimeslot:[dictionary objectForKey:@"timeslot"]];
		}

		return self;
	}
@end
