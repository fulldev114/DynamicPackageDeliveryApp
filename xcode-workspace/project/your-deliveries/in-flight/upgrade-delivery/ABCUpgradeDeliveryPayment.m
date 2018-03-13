//
//  ABCUpgradeDeliveryPayment.m
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCUpgradeDeliveryPayment.h"

#import "AppDelegate.h"

@interface ABCUpgradeDeliveryPayment()
@end

@implementation ABCUpgradeDeliveryPayment
	- (CGFloat) SizePaymentHeight {
		return 85.0f;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self initialise];

		return self;
	}

	- (void) initialise {
		CGFloat top = 0.0f;
		CGFloat width = [[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f);

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:1];
		[label setText:NSLocalizedString(@"Payment", nil)];
		[label setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			width,
			[[UIScreen mainScreen] bounds].size.height)];

		[label setFrame:CGRectMake(
			0.0f,
			top,
			labelSize.width,
			labelSize.height)];

		top += labelSize.height;

		top += [AppDelegate SizePaddingFromSidesThin];

		UIView* view = [[UIView alloc] init];
		[self addSubview:view];
		[[view layer] setCornerRadius:[AppDelegate SizeCornerRadius]];
		[view setBackgroundColor:[UIColor whiteColor]];
		[view setClipsToBounds:YES];
		[view setFrame:CGRectMake(
			0.0f,
			top,
			width,
			[self SizePaymentHeight])];

		top += [self SizePaymentHeight];

		[self setSizeView:CGSizeMake(
			width,
			top)];
	}
@end
