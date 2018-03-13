//
//  ABCDeliveryToDepotNoteBringId.m
//  your-dpd
//
//  Created by Richard Simkins on 19/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryToDepotNoteBringId.h"

#import "AppDelegate.h"

@interface ABCDeliveryToDepotNoteBringId()
@end

@implementation ABCDeliveryToDepotNoteBringId
	- (instancetype) init {
		self = [super
			initWithText:NSLocalizedString(@"Please bring two pieces of ID, including a photo ID and a utility bill", nil)
			andIcon:YES];

		if (!self) return nil;

		return self;
	}
@end
