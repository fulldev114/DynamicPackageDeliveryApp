//
//  ABCDeliveryTodayDropOffChoice.m
//  your-dpd
//
//  Created by Richard Simkins on 14/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryTodayDropOffChoice.h"

#import "AppDelegate.h"

@interface ABCDeliveryTodayDropOffChoice()
@end

@implementation ABCDeliveryTodayDropOffChoice
	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			52.0f)];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setBackgroundColor:[AppDelegate ColourAppRed]];

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setAttributedText:[[NSAttributedString alloc]
			initWithString:@"Leave in safe place as per your preference"
			attributes:@{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:12.0f],
				NSForegroundColorAttributeName:[UIColor whiteColor],
			}]];
		[label setNumberOfLines:1];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self sizeView].width,
			[self sizeView].height)];

		[label setFrame:CGRectMake(
			([self sizeView].width - labelSize.width) / 2.0f,
			([self sizeView].height - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];
	}
@end
