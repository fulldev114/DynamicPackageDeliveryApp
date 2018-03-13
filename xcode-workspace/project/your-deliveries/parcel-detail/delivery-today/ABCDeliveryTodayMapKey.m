//
//  ABCDeliveryTodayMapKey.m
//  your-dpd
//
//  Created by Richard Simkins on 11/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryTodayMapKey.h"

#import "ABCPin.h"
#import "AppDelegate.h"

@interface ABCDeliveryTodayMapKey()
@end

@implementation ABCDeliveryTodayMapKey
	- (CGFloat) SizeLabelWidth {
		return 50.0f;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			64.0f)];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setBackgroundColor:[AppDelegate ColourAppBlack]];

		[self
			keyWithPinImage:@"pin-driver.png"
			andLabelText:NSLocalizedString(@"Your driver, Brian", nil)
			andIndex:0];
		[self
			keyWithPinImage:@"pin-home.png"
			andLabelText:NSLocalizedString(@"Delivery Address", nil)
			andIndex:1];
		[self
			keyWithPinImage:@"pin-user-placeholder.png"
			andLabelText:NSLocalizedString(@"Your Location", nil)
			andIndex:2];
	}

	- (CGFloat) arrowPosition {
		return [self spreadWithIndex:2] + (([ABCPin SizeViewWidth] + [self SizeLabelWidth]) / 2.0f);
	}

	- (void)
		keyWithPinImage:(NSString*)pinImage
		andLabelText:(NSString*)labelText
		andIndex:(NSInteger)index {

		CGFloat left = [self spreadWithIndex:index];

		ABCPin* pin = [[ABCPin alloc] initWithImage:pinImage];
		[self addSubview:pin];
		[pin setFrame:CGRectMake(
			left,
			([self sizeView].height - [ABCPin SizeViewHeight]) / 2.0f,
			[ABCPin SizeViewWidth],
			[ABCPin SizeViewHeight])];

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:8.0f]];
		[label setNumberOfLines:2];
		[label setText:labelText];
		[label setTextColor:[UIColor whiteColor]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self SizeLabelWidth],
			[self sizeView].height)];

		[label setFrame:CGRectMake(
			left + [ABCPin SizeViewWidth],
			([self sizeView].height - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];
	}

	- (CGFloat) spreadWithIndex:(NSInteger)index {
		CGFloat left = [ABCPin SizeViewWidth] + [self SizeLabelWidth];
		left *= 3.0f;
		left = [self sizeView].width - left;
		left /= 3.0f;
		left = left + ((left + [ABCPin SizeViewWidth] + [self SizeLabelWidth]) * ((CGFloat) index));

		return left;
	}
@end
