//
//  ABCNotice.m
//  your-dpd
//
//  Created by Richard Simkins on 19/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCNotice.h"

#import "AppDelegate.h"

@interface ABCNotice()
	@property (nonatomic) BOOL icon;
	@property (nonatomic) NSString* text;
@end

@implementation ABCNotice
	- (CGFloat) SizePaddingLeft {
		return [self icon]
			? 68.0f
			: [AppDelegate SizePaddingFromSides];
	}

	- (CGFloat) SizePaddingRight {
		return [self icon]
			? 0.0f
			: [AppDelegate SizePaddingFromSides];
	}

	- (instancetype)
		initWithText:(NSString*)text
		andIcon:(BOOL)icon {

		self = [super init];

		if (!self) return nil;

		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			40.0f)];
		[self setText:text];
		[self setIcon:icon];
		[self initialise];

		return self;
	}

	- (void) initialise {
		if ([self icon]) {
			UIImageView* icon = [[UIImageView alloc] initWithFrame:CGRectMake(
				([self SizePaddingLeft] - [AppDelegate SizeIcon25]) / 2.0f,
				([self sizeView].height - [AppDelegate SizeIcon25]) / 2.0f,
				[AppDelegate SizeIcon25],
				[AppDelegate SizeIcon25])];
			[self addSubview:icon];
			[icon setContentMode:UIViewContentModeScaleAspectFill];
			[icon setImage:[UIImage imageNamed:@"notice.png"]];
		}

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:2];
		[label setText:[self text]];

		if (![self icon]) {
			[label setTextAlignment:NSTextAlignmentCenter];
		}

		[label setTextColor:[AppDelegate ColourAppRed]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self sizeView].width - [self SizePaddingLeft] - [self SizePaddingRight],
			[self sizeView].height)];

		[label setFrame:CGRectMake(
			[self SizePaddingLeft],
			([self sizeView].height - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];
	}
@end
