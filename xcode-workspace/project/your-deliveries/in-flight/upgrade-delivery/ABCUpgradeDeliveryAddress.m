//
//  ABCUpgradeDeliveryAddress.m
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCUpgradeDeliveryAddress.h"

#import "AppDelegate.h"

@interface ABCUpgradeDeliveryAddress()
	@property (nonatomic) UITextView* textView;
@end

@implementation ABCUpgradeDeliveryAddress
	- (CGFloat) SizeTextViewHeight {
		return 85.0f;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self initialise];

		return self;
	}

	- (void) bringToTopOfScrollView:(UIScrollView*)scrollview {
		if (![[self textView] isEditable]) return;

		[scrollview bringSubviewToFront:[self textView]];
	}

	- (void) initialise {
		CGFloat top = 0.0f;
		CGFloat width = [[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f);

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:1];
		[label setText:NSLocalizedString(@"Your delivery address is:", nil)];
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
			width,
			[self SizeTextViewHeight])];

		top += [self SizeTextViewHeight];

		[self setTextView:[[UITextView alloc] init]];
		[[self textView] setText:@"24 College Drive, Manchester, M16 OAE"];

		[self setSizeView:CGSizeMake(
			width,
			top)];
	}

	- (void) resign {
		[[self textView] resignFirstResponder];
		[[self textView] setEditable:YES];
	}

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y {

		CGFloat height = [super
			setPositionX:x
			andPositionY:y];

		// o A hack, but a better solution that scrollViewDidScroll.
		[[self superview] addSubview:[self textView]];
		[[self textView] setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSides] + [AppDelegate SizePaddingFromSidesThin],
			y + height - [self SizeTextViewHeight] + [AppDelegate SizePaddingFromSidesThin],
			[self sizeView].width - ([AppDelegate SizePaddingFromSidesThin] * 2.0f),
			[self SizeTextViewHeight] - ([AppDelegate SizePaddingFromSidesThin] * 2.0f))];

		return height;
	}

	- (void) textViewAddToScrollView:(UIScrollView*)scrollview {
		// o A hack, but a better solution that scrollViewDidScroll.
		[scrollview addSubview:[self textView]];
	}
@end
