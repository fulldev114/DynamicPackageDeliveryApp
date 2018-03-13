//
//  ABCBasicAddressNote.m
//  your-dpd
//
//  Created by Richard Simkins on 16/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCBasicAddressNote.h"

#import "AppDelegate.h"

@interface ABCBasicAddressNote()
	@property (nonatomic) UITextView* textView;
@end

@implementation ABCBasicAddressNote
	- (CGFloat) SizeTextViewHeight {
		return 85.0f;
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
		[label setText:NSLocalizedString(@"Address notes for our driver:", nil)];
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

		[self setTextView:[[UITextView alloc] init]];
		[[self textView] setBackgroundColor:[UIColor whiteColor]];
	}

	- (void) setHidden:(BOOL)hidden {
		[super setHidden:hidden];
		[[self textView] setHidden:hidden];
	}

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y {

		CGFloat height = [super
			setPositionX:x
			andPositionY:y];

		[[self textView] setFrame:CGRectMake(
			x,
			y + [self sizeView].height - [self SizeTextViewHeight],
			[self sizeView].width,
			[self SizeTextViewHeight]
		)];

		return height;
	}

	- (NSArray*) viewCollectionForScrollViewForeground {
		return @[
			[self textView],
		];
	}
@end