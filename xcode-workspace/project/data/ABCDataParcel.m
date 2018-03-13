//
//  ABCDataParcel.m
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDataParcel.h"

@interface ABCDataParcel()
@end

@implementation ABCDataParcel
	- (instancetype) initWithNSDictionary:(NSDictionary *)dictionary {
		self = [super init];

		if (!self) return nil;

		[self setDispatcherName:@"Parcel"];

		if ([self validValueInDictionary:dictionary forKey:@"collector_name"]) {
			[self setCollectorName:[dictionary objectForKey:@"collector_name"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"depot_address"]) {
			[self setDepotAddress:[dictionary objectForKey:@"depot_address"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"dispatcher_name"]) {
			[self setDispatcherName:[dictionary objectForKey:@"dispatcher_name"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"driver_name"]) {
			[self setDriverName:[dictionary objectForKey:@"driver_name"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"image_url"]) {
			[self setImgurUrl:[dictionary objectForKey:@"image_url"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"reference_number"]) {
			[self setReferenceNumber:[dictionary objectForKey:@"reference_number"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"status"]) {
			[self setStatus:[dictionary objectForKey:@"status"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"time_delivery_complete"]) {
			[self setTimeDeliveryComplete:[dictionary objectForKey:@"time_delivery_complete"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"time_delivery_estimate"]) {
			[self setTimeDeliveryEstimate:[dictionary objectForKey:@"time_delivery_estimate"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"time_delivery_depot_on_day"]) {
			[self setTimeDeliveryOnDay:[dictionary objectForKey:@"time_delivery_depot_on_day"]];
		}

		if ([self validValueInDictionary:dictionary forKey:@"time_delivery_depot_from_time"]) {
			[self setTimeDeliveryFromTime:[dictionary objectForKey:@"time_delivery_depot_from_time"]];
		}

		return self;
	}
@end
