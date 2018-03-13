//
//  ABCBasicAddressSpecifyOther.m
//  your-dpd
//
//  Created by Richard Simkins on 15/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCBasicAddressSpecifyOther.h"

#import "AppDelegate.h"

@interface ABCBasicAddressSpecifyOther()
	@property (nonatomic) UITextField* textField;
@end

@implementation ABCBasicAddressSpecifyOther
	- (CGFloat) SizeTextViewHeight {
		return 48.0f;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;
		[self initialise];

		return self;
	}

	- (void) initialise {
		CGFloat width = [[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f);
		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:1];
		[label setText:NSLocalizedString(@"Please specify other", nil)];
		[label setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			width,
			[[UIScreen mainScreen] bounds].size.width)];

		[label setFrame:CGRectMake(
			0.0f,
			0.0f,
			labelSize.width,
			labelSize.height)];

		[self setSizeView:CGSizeMake(
			width,
			labelSize.height + [AppDelegate SizePaddingFromSidesThin] + [self SizeTextViewHeight])];

		[self setTextField:[[UITextField alloc] init]];
		[[self textField] setBackgroundColor:[UIColor whiteColor]];
	}

	- (void) setHidden:(BOOL)hidden {
		[super setHidden:hidden];
		[[self textField] setHidden:hidden];
	}

	- (void) empty {
		[[self textField] setText:@""];
	}

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y {

		[UIView setAnimationsEnabled:NO];
		CGFloat height = [super
			setPositionX:x
			andPositionY:y];

		[[self textField] setFrame:CGRectMake(
			x,
			y + [self sizeView].height - [self SizeTextViewHeight],
			[self sizeView].width,
			[self SizeTextViewHeight]
		)];
		[UIView setAnimationsEnabled:YES];

		return height;
	}

	- (NSArray*) viewCollectionForScrollViewForeground {
		return @[
			[self textField],
		];
	}
@end