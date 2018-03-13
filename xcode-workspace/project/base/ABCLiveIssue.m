//
//  ABCLiveIssue.m
//  your-dpd
//
//  Created by Richard Simkins on 21/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCLiveIssue.h"

#import "ABCAlertArrow.h"
#import "AppDelegate.h"

@interface ABCLiveIssue()
@end

@implementation ABCLiveIssue
	- (CGFloat) SizePaddingLeft {
		return 63.0f;
	}
	- (CGFloat) SizePaddingRight {
		return 11.0f;
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
		[label setFont:[AppDelegate FontRegularWithSize:10.0f]];
		[label setNumberOfLines:0];
		[label setText:[self text]];
		[label setTextColor:[UIColor whiteColor]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self sizeView].width - [self SizePaddingLeft] - [self SizePaddingRight],
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
		[icon setImage:[UIImage imageNamed:@"live-issue-snow.png"]];

		ABCAlertArrow* arrow = [[ABCAlertArrow alloc] init];
		[self addSubview:arrow];
		[arrow setPosition:CGPointMake(
			[self sizeView].width / 2.0f,
			0.0f)];
	}
@end
