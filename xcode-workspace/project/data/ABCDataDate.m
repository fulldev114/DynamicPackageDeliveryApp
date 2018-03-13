//
//  ABCDataDate.m
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDataDate.h"

@interface ABCDataDate()
@end

@implementation ABCDataDate
	- (instancetype) initWithNSDictionary:(NSDictionary *)dictionary {
		self = [super init];

		if (!self) return nil;

		if ([self validValueInDictionary:dictionary forKey:@"date"]) {
			[self setDate:[dictionary objectForKey:@"date"]];
		}

		return self;
	}
@end
