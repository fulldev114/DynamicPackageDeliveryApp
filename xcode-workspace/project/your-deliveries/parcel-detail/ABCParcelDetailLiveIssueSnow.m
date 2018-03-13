//
//  ABCParcelDetailLiveIssueSnow.m
//  your-dpd
//
//  Created by Richard Simkins on 21/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCParcelDetailLiveIssueSnow.h"

@interface ABCParcelDetailLiveIssueSnow()
@end

@implementation ABCParcelDetailLiveIssueSnow
	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		NSString* text = NSLocalizedString(@"Your parcel has been delayed due to Snow in your area. Your estimated delivery date is", nil);
		[self setText:[NSString stringWithFormat:@"%@ %@", text, @"16/03/15"]];
		[self initialise];

		return self;
	}
@end
