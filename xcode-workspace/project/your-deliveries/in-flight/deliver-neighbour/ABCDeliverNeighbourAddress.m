//
//  ABCDeliverNeighbourAddress.m
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliverNeighbourAddress.h"

#import "AppDelegate.h"

@interface ABCDeliverNeighbourAddress()
	@property (nonatomic) ABCDataAddress* dataAddress;
@end

@implementation ABCDeliverNeighbourAddress
	- (instancetype)
		initWithDataAddress:(ABCDataAddress*)dataAddress
		andSizeView:(CGSize)sizeView {

		self = [super init];

		if (!self) return nil;

		[self setDataAddress:dataAddress];
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

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:1];
		[label setText:[[self dataAddress] address]];
		[label setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self sizeView].width,
			[self sizeView].height)];

		[label setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSides],
			([self sizeView].height - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];

		[self setRadio:[[ABCRadio alloc] init]];
		[self addSubview:[self radio]];
		[[self radio] setFrame:CGRectMake(
			[self sizeView].width - [AppDelegate SizePaddingFromSides] - [[self radio] SizeView],
			([self sizeView].height - [[self radio] SizeView]) / 2.0f,
			[[self radio] SizeView],
			[[self radio] SizeView])];
	}
@end
