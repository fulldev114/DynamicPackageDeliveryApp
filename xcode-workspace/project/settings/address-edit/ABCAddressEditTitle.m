//
//  ABCAddressEditTitle.m
//  your-dpd
//
//  Created by Richard Simkins on 12/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCAddressEditTitle.h"

#import "AppDelegate.h"

@interface ABCAddressEditTitle()
@end

@implementation ABCAddressEditTitle
	- (CGFloat) SizePaddingLeft {
		return 56.0f;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			32.0f)];
		[self initialise];

		return self;
	}

	- (void) initialise {
		UIImageView* imageView = [[UIImageView alloc] init];
		[self addSubview:imageView];
		[imageView setContentMode:UIViewContentModeScaleAspectFit];
		[imageView setFrame:CGRectMake(
			([self SizePaddingLeft] - [AppDelegate SizeIcon40]) / 2.0f,
			([self sizeView].height - [AppDelegate SizeIcon40]) / 2.0f,
			[AppDelegate SizeIcon40],
			[AppDelegate SizeIcon40])];
		[imageView setImage:[UIImage imageNamed:@"settings-house.png"]];

		UILabel* title = [[UILabel alloc] init];
		[self addSubview:title];
		[title setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[title setNumberOfLines:1];
		[title setText:[NSString stringWithFormat:@"%@ Preferences", @"24 College Drive"]];
		[title setTextColor:[AppDelegate ColourAppRed]];
		CGSize titleSize = [title sizeThatFits:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f) - [self SizePaddingLeft],
			[self sizeView].height)];
		[title setFrame:CGRectMake(
			[self SizePaddingLeft],
			(([self sizeView].height - titleSize.height) / 2.0f) + 2.0f,
			titleSize.width,
			titleSize.height)];
	}
@end
