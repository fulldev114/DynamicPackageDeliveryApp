//
//  ABCDeliveryToDepotDirection.m
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryToDepotDirection.h"

#import "AppDelegate.h"

@interface ABCDeliveryToDepotDirection()
	@property (nonatomic) ABCDataDirection* dataDirection;
	@property (nonatomic) NSUInteger index;
@end

@implementation ABCDeliveryToDepotDirection
	- (CGFloat) SizePaddingLeftDirections {
		return 52.0f;
	}

	- (CGFloat) SizePaddingLeftIndex {
		return 38.0f;
	}

	- (CGFloat) SizePaddingRightDirections {
		return 52.0f;
	}

	- (instancetype)
		initWithDataDirection:(ABCDataDirection*)dataDirection
		andIndex:(NSUInteger)index
		andSizeView:(CGSize)sizeView {

		self = [super init];

		if (!self) return nil;

		[self setDataDirection:dataDirection];
		[self setIndex:index];
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

		UILabel* labelIndex = [[UILabel alloc] init];
		[self addSubview:labelIndex];
		[labelIndex setFont:[AppDelegate FontRegularWithSize:9.0f]];
		[labelIndex setNumberOfLines:1];
		[labelIndex setText:[NSString stringWithFormat:@"%lu.", [self index] + 1]];
		[labelIndex setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelIndexSize = [labelIndex sizeThatFits:[self sizeView]];

		[labelIndex setFrame:CGRectMake(
			[self SizePaddingLeftIndex],
			[AppDelegate SizePaddingFromSidesThin],
			labelIndexSize.width,
			labelIndexSize.height)];

		UILabel* labelDirections = [[UILabel alloc] init];
		[self addSubview:labelDirections];
		[labelDirections setFont:[AppDelegate FontRegularWithSize:9.0f]];
		[labelDirections setNumberOfLines:0];
		[labelDirections setText:[[self dataDirection] directions]];
		[labelDirections setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelDirectionsSize = [labelDirections sizeThatFits:CGSizeMake(
			[self sizeView].width - [self SizePaddingLeftDirections] - [self SizePaddingRightDirections],
			[self sizeView].height)];

		[labelDirections setFrame:CGRectMake(
			[self SizePaddingLeftDirections],
			[AppDelegate SizePaddingFromSidesThin],
			labelDirectionsSize.width,
			labelDirectionsSize.height)];

		UILabel* labelDistance = [[UILabel alloc] init];
		[self addSubview:labelDistance];
		[labelDistance setFont:[AppDelegate FontRegularWithSize:9.0f]];
		[labelDistance setNumberOfLines:1];
		[labelDistance setText:[NSString stringWithFormat:@"%@ft", [[self dataDirection] distance]]];
		[labelDistance setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelDistanceSize = [labelDistance sizeThatFits:[self sizeView]];

		[labelDistance setFrame:CGRectMake(
			[self sizeView].width - [AppDelegate SizePaddingFromSides] - labelDistanceSize.width,
			[AppDelegate SizePaddingFromSidesThin],
			labelDistanceSize.width,
			labelDistanceSize.height)];
	}
@end
