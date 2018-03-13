//
//  ABCParcelDetailLocation.m
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCParcelDetailLocation.h"

#import "AppDelegate.h"

@interface ABCParcelDetailLocation()
	@property (nonatomic) ABCDataParcelLocation* dataParcelLocation;
@end

@implementation ABCParcelDetailLocation
	+ (CGFloat) SizeColumnOneWidth {
		return 80.0f;
	}

	+ (CGFloat) SizeColumnTwoWidth {
		return 75.0f;
	}

	- (instancetype)
		initWithDataParcelLocation:(ABCDataParcelLocation*)dataParcelLocation
		andSizeView:(CGSize)sizeView {

		self = [super init];

		if (!self) return nil;

		[self setDataParcelLocation:dataParcelLocation];
		[self setSizeView:sizeView];

		[self initialise];

		return self;
	}

	- (void) initialise {
		UIView* horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(
			0.0f,
			0.0f,
			[self sizeView].width,
			[AppDelegate SizeSeparationThickness])];
		[self addSubview:horizontalLine];
		[horizontalLine setBackgroundColor:[AppDelegate ColourAppGreyLight]];

		UILabel* label;

		label = [self
			cellLabelWithText:[[self dataParcelLocation] eventDate]
			andWidth:[ABCParcelDetailLocation SizeColumnOneWidth]
			andLeft:0.0f];
		[self addSubview:label];

		label = [self
			cellLabelWithText:[[self dataParcelLocation] placeName]
			andWidth:[ABCParcelDetailLocation SizeColumnTwoWidth]
			andLeft:[ABCParcelDetailLocation SizeColumnOneWidth]];
		[self addSubview:label];

		label = [self
			cellLabelWithText:[[self dataParcelLocation] eventDescription]
			andWidth:[self sizeView].width - [ABCParcelDetailLocation SizeColumnOneWidth] - [ABCParcelDetailLocation SizeColumnTwoWidth]
			andLeft:[ABCParcelDetailLocation SizeColumnOneWidth] + [ABCParcelDetailLocation SizeColumnTwoWidth]];
		[self addSubview:label];
	}

	- (UILabel*)
		cellLabelWithText:(NSString*)text
		andWidth:(CGFloat)width
		andLeft:(CGFloat)left {

		UILabel* label = [[UILabel alloc] init];
		[label setFont:[AppDelegate FontRegularWithSize:10.0f]];
		[label setNumberOfLines:0];
		[label setText:text];
		[label setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			width - ([AppDelegate SizePaddingFromSidesThin] * 2.0f),
			[self sizeView].height)];

		[label setFrame:CGRectMake(
			left + [AppDelegate SizePaddingFromSidesThin],
			([self sizeView].height - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];

		return label;
	}
@end
