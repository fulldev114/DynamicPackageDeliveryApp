//
//  ABCRadio.m
//  your-dpd
//
//  Created by Richard Simkins on 15/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCRadio.h"

#import "AppDelegate.h"

@interface ABCRadio()
	@property (nonatomic) UIView* dot;
@end

@implementation ABCRadio
	- (CGFloat) SizeView {
		return 18.0f;
	}

	- (CGFloat) SizeDot {
		return 14.0f;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[[self layer] setCornerRadius:[self SizeView] / 2.0f];
		[self setBackgroundColor:[AppDelegate ColourAppGreyLight]];
		[self setClipsToBounds:YES];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setDot:[[UIView alloc] initWithFrame:CGRectMake(
			([self SizeView] - [self SizeDot]) / 2.0f,
			([self SizeView] - [self SizeDot]) / 2.0f,
			[self SizeDot],
			[self SizeDot])]];
		[self addSubview:[self dot]];
		[[[self dot] layer] setCornerRadius:[self SizeDot] / 2.0f];
		[[self dot] setBackgroundColor:[AppDelegate ColourAppRed]];
		[[self dot] setClipsToBounds:YES];
		[[self dot] setHidden:YES];
	}

	- (BOOL) isSelected {
		return ![[self dot] isHidden];
	}

	- (void) setSelected:(BOOL)selected {
		[[self dot] setHidden:!selected];
	}
@end
