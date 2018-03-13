//
//  ABCSettingsSection.m
//  your-dpd
//
//  Created by Richard Simkins on 01/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCSettingsSection.h"

#import "AppDelegate.h"

@interface ABCSettingsSection()
	@property (nonatomic) NSString* title;
@end

@implementation ABCSettingsSection
	+ (CGFloat) SizeMarginTop {
		return 27.0f;
	}

	- (instancetype) initWithTitle:(NSString*)title {
		self = [super init];

		if (!self) return nil;

		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			36.0f)];
		[self setTitle:title];
		[self initialise];

		return self;
	}

	- (void) initialise {
		UILabel* title = [[UILabel alloc] init];
		[self addSubview:title];
		[title setFont:[AppDelegate FontRegularWithSize:16.0f]];
		[title setNumberOfLines:1];
		[title setText:[self title]];
		[title setTextColor:[AppDelegate ColourAppRed]];
		CGSize titleSize = [title sizeThatFits:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width,
			[self sizeView].height)];
		[title setFrame:CGRectMake(
			0.0f,
			(([self sizeView].height - titleSize.height) / 2.0f) + 2.0f,
			titleSize.width,
			titleSize.height)];
	}
@end
