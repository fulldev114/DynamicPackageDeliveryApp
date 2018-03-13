//
//  ABCAlert.m
//  your-dpd
//
//  Created by Richard Simkins on 11/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCAlert.h"

#import "AppDelegate.h"

@interface ABCAlert()
@end

@implementation ABCAlert
	- (CGFloat) SizePaddingLeft {
		return 42.0f;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			51.0f)];

		return self;
	}

	- (void) initialise {
		// # Can not [self setClipsToBounds:YES] because the red arrow view is positioned outside
		//   this view.
		UIView* background = [[UIView alloc] initWithFrame:CGRectMake(
			0.0f,
			0.0f,
			[self sizeView].width,
			[self sizeView].height)];
		[self addSubview:background];
		[[background layer] setCornerRadius:[AppDelegate SizeCornerRadius]];
		[background setBackgroundColor:[AppDelegate ColourAppRed]];
		[background setClipsToBounds:YES];

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:2];
		[label setText:[self text]];
		[label setTextColor:[UIColor whiteColor]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self sizeView].width - [self SizePaddingLeft] - [AppDelegate SizeIcon25],
			[self sizeView].height)];
		[label setFrame:CGRectMake(
			[self SizePaddingLeft],
			([self sizeView].height - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];

		UIImageView* icon = [[UIImageView alloc] initWithFrame:CGRectMake(
			([self SizePaddingLeft] - [AppDelegate SizeIcon25]) / 2.0f,
			([self sizeView].height - [AppDelegate SizeIcon25]) / 2.0f,
			[AppDelegate SizeIcon25],
			[AppDelegate SizeIcon25])];
		[self addSubview:icon];
		[icon setContentMode:UIViewContentModeScaleAspectFill];
		[icon setImage:[UIImage imageNamed:@"alert.png"]];

		if ([self selector]) {
			UIImageView* arrow = [[UIImageView alloc] initWithFrame:CGRectMake(
				[self sizeView].width - [AppDelegate SizeIcon25],
				([self sizeView].height - [AppDelegate SizeIcon25]) / 2.0f,
				[AppDelegate SizeIcon25],
				[AppDelegate SizeIcon25])];
			[self addSubview:arrow];
			[arrow setContentMode:UIViewContentModeScaleAspectFill];
			[arrow setImage:[UIImage imageNamed:@"alert-arrow.png"]];

			UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
			[self addSubview:button];
			[button
				addTarget:self
				action:[self selector]
				forControlEvents:UIControlEventTouchUpInside];
			[button setFrame:CGRectMake(
				0.0f,
				0.0f,
				[self sizeView].width,
				[self sizeView].height)];
		}
	}
@end
