//
//  ABCYourProfileInput.m
//  your-dpd
//
//  Created by Richard Simkins on 03/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourProfileFullname.h"

#import "AppDelegate.h"

@interface ABCYourProfileFullname()
	@property (nonatomic) UITextField* firstname;
	@property (nonatomic) CGFloat columnLeft;
	@property (nonatomic) UITextField* surname;
@end

@implementation ABCYourProfileFullname
	- (CGFloat) SizeTextViewHeight {
		return 48.0f;
	}

	- (instancetype) initWithColumnLeftSize:(CGSize)columnLeftSize {
		self = [super init];

		if (!self) return nil;

		[self setColumnLeft:columnLeftSize.width];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f) - [AppDelegate SizePaddingFromSidesThin] - columnLeftSize.width,
			columnLeftSize.height)];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setFirstname:[[UITextField alloc] init]];
		[[self firstname] setBackgroundColor:[UIColor whiteColor]];
		[self setSurname:[[UITextField alloc] init]];
		[[self surname] setBackgroundColor:[UIColor whiteColor]];
	}

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y {

		x += [AppDelegate SizePaddingFromSides] + [self columnLeft];
		CGFloat height = [super
			setPositionX:x
			andPositionY:y];

		[[self firstname] setFrame:CGRectMake(
			x,
			y,
			[self sizeView].width,
			[self SizeTextViewHeight]
		)];
		[[self surname] setFrame:CGRectMake(
			x,
			y + [self sizeView].height - [self SizeTextViewHeight],
			[self sizeView].width,
			[self SizeTextViewHeight]
		)];

		return height;
	}

	- (NSArray*) viewCollectionForScrollViewForeground {
		return @[
			[self firstname],
			[self surname],
		];
	}
@end