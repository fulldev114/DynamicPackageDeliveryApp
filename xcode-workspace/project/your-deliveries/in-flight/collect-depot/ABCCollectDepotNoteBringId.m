//
//  ABCCollectDepotNoteBringId.m
//  your-dpd
//
//  Created by Richard Simkins on 27/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCCollectDepotNoteBringId.h"

#import "AppDelegate.h"

@interface ABCCollectDepotNoteBringId()
@end

@implementation ABCCollectDepotNoteBringId
	- (instancetype) init {
		self = [super
			initWithText:NSLocalizedString(@"Please bring two pieces of ID, including a photo ID and a utility bill", nil)
			andIcon:NO];

		if (!self) return nil;

		return self;
	}
@end
