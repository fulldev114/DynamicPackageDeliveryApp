//
//  ABCDeliverSafePlacePhoto.m
//  your-dpd
//
//  Created by Richard Simkins on 22/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliverSafePlacePhoto.h"

#import "AppDelegate.h"

@interface ABCDeliverSafePlacePhoto()
@end

@implementation ABCDeliverSafePlacePhoto
	- (CGFloat) SizeButton {
		return 105.0f;
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
		[label setText:NSLocalizedString(@"Add photo of your safe place", nil)];
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
		[view setBackgroundColor:[UIColor whiteColor]];
		[view setFrame:CGRectMake(
			0.0f,
			top,
			[self SizeButton],
			[self SizeButton])];

		top += [self SizeButton];

		UIImageView* imageView = [[UIImageView alloc] init];
		[view addSubview:imageView];
		[imageView setFrame:CGRectMake(
			([self SizeButton] - [AppDelegate SizeIcon40]) / 2.0f,
			([self SizeButton] - [AppDelegate SizeIcon40]) / 2.0f,
			[AppDelegate SizeIcon40],
			[AppDelegate SizeIcon40])];
		[imageView setImage:[UIImage imageNamed:@"deliver-safe-place-take-photo.png"]];

		UILabel* labelButton = [[UILabel alloc] init];
		[view addSubview:labelButton];
		[labelButton setFont:[AppDelegate FontRegularWithSize:8.0f]];
		[labelButton setNumberOfLines:1];
		[labelButton setText:NSLocalizedString(@"Add Photo", nil)];
		[labelButton setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelButtonSize = [labelButton sizeThatFits:CGSizeMake(
			[self SizeButton],
			[self SizeButton])];

		[labelButton setFrame:CGRectMake(
			([self SizeButton] - labelButtonSize.width) / 2.0f,
			(([self SizeButton] - [AppDelegate SizeIcon40]) / 2.0f) + [AppDelegate SizeIcon40],
			labelButtonSize.width,
			labelButtonSize.height)];

		UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
		[view addSubview:button];
		[button
			addTarget:self
			action:@selector(tap)
			forControlEvents:UIControlEventTouchUpInside];
		[button setFrame:CGRectMake(
			0.0f,
			0.0f,
			[AppDelegate SizeIcon40],
			[AppDelegate SizeIcon40])];

		[self setSizeView:CGSizeMake(
			width,
			top)];
	}

	- (void) tap {
		NSLog(@"tap add photo");
	}
@end
