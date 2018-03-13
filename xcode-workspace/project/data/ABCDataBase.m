//
//  ABCDataBase.m
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDataBase.h"

@interface ABCDataBase()
@end

@implementation ABCDataBase
	- (BOOL)
		validArrayInDictionary:(NSDictionary*)dictionary
		forKey:(NSString*)key {

		return [dictionary objectForKey:key]
			&& ![[dictionary objectForKey:key] isEqual:[NSNull null]]
			&& [[dictionary objectForKey:key] isKindOfClass:[NSArray class]];
	}

	- (BOOL)
		validDictionaryInDictionary:(NSDictionary*)dictionary
		forKey:(NSString*)key {

		return [dictionary objectForKey:key]
			&& ![[dictionary objectForKey:key] isEqual:[NSNull null]]
			&& [[dictionary objectForKey:key] isKindOfClass:[NSDictionary class]];
	}

	- (BOOL)
		validValueInDictionary:(NSDictionary*)dictionary
		forKey:(NSString*)key {

		return [dictionary objectForKey:key]
			&& ![[dictionary objectForKey:key] isEqual:[NSNull null]];
	}
@end
