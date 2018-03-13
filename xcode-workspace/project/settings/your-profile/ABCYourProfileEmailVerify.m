//
//  ABCYourProfileEmailVerify.m
//  your-dpd
//
//  Created by Richard Simkins on 09/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourProfileEmailVerify.h"

#import "AppDelegate.h"

@interface ABCYourProfileEmailVerify()
	@property (nonatomic, strong) BlockYourProfileEmailVerifyTap blockTap;
	@property (nonatomic) UIButton* button;
@end

@implementation ABCYourProfileEmailVerify
	- (instancetype) initWithBlockTap:(BlockYourProfileEmailVerifyTap)blockTap {
		self = [super init];

		if (!self) return nil;

		[self setBlockTap:blockTap];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			48.0f)];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setButton:[UIButton buttonWithType:UIButtonTypeCustom]];
		[[self button]
			addTarget:self
			action:@selector(tap)
			forControlEvents:UIControlEventTouchUpInside];
		[[self button] setBackgroundColor:[AppDelegate ColourAppRed]];
		[[self button]
			setTitle:NSLocalizedString(@"Request PIN", nil)
			forState:UIControlStateNormal];
		[[self button]
			setTitleColor:[UIColor whiteColor]
			forState:UIControlStateNormal];
		[[[self button] titleLabel] setFont:[AppDelegate FontRegularWithSize:16.0f]];
	}

	- (void) setHidden:(BOOL)hidden {
		[super setHidden:hidden];
		[[self button] setHidden:hidden];
	}

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y {

		CGFloat height = [super
			setPositionX:0.0f
			andPositionY:0.0f];

		[[self button] setFrame:CGRectMake(
			x,
			y,
			[self sizeView].width,
			[self sizeView].height)];

		return height;
	}

	- (void) tap {
		[self blockTap]();
	}

	- (NSArray*) viewCollectionForScrollViewForeground {
		return @[
			[self button],
		];
	}
@end