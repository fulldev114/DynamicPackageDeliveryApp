//
//  ABCDeliveryCompleteGallery.m
//  your-dpd
//
//  Created by Richard Simkins on 21/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryCompleteGallery.h"

#import "AppDelegate.h"

@interface ABCDeliveryCompleteGallery()
	@property (nonatomic, strong) BlockItemTapped blockItemTapped;
	@property (nonatomic) UILabel* label;
@end

@implementation ABCDeliveryCompleteGallery
	- (CGFloat) SizePreview {
		return 86.0f;
	}

	- (instancetype) initWithBlockItemTapped:(BlockItemTapped)blockItemTapped {
		self = [super init];

		if (!self) return nil;

		[self setBlockItemTapped:blockItemTapped];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			142.0f)];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setBackgroundColor:[UIColor whiteColor]];

		[self setLabel:[[UILabel alloc] init]];
		[self addSubview:[self label]];
		[[self label] setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[[self label] setNumberOfLines:1];
		[[self label] setText:NSLocalizedString(@"Click an image to view larger version", nil)];
		[[self label] setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelSize = [[self label] sizeThatFits:CGSizeMake(
			[self sizeView].width - ([AppDelegate SizePaddingFromSidesThin] * 2.0f),
			[self sizeView].height)];

		[[self label] setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSidesThin],
			[AppDelegate SizePaddingFromSidesThin],
			labelSize.width,
			labelSize.height)];

		[self buttonAddWithIndex:0];
		[self buttonAddWithIndex:1];
		[self buttonAddWithIndex:2];
	}

	- (void) buttonAddWithIndex:(NSUInteger)index {
		NSUInteger buttonCount = 3;
		CGFloat paddingLeft = [self SizePreview];
		paddingLeft += (([self sizeView].width - ([AppDelegate SizePaddingFromSidesThin] * 2.0f)) - ([self SizePreview] * buttonCount)) / (buttonCount - 1);
		UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
		[self addSubview:button];
		[button
			addTarget:self
			action:@selector(buttonTap:)
			forControlEvents:UIControlEventTouchUpInside];
		[button setBackgroundColor:[UIColor yellowColor]];
		[button setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSidesThin] + (paddingLeft * index),
			[[self label] frame].origin.y + [[self label] frame].size.height + [AppDelegate SizePaddingFromSides],
			[self SizePreview],
			[self SizePreview])];
		[button setTag:index];
	}

	- (void) buttonTap:(UIButton*)sender {
		[self blockItemTapped]([sender tag]);
	}
@end
