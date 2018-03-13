//
//  ABCCollectDepotAddressDepot.m
//  your-dpd
//
//  Created by Richard Simkins on 27/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCCollectDepotAddressDepot.h"

#import "ABCPin.h"
#import "AppDelegate.h"

@interface ABCCollectDepotAddressDepot()
	@property (nonatomic) ABCDataAddress* dataAddress;
@end

@implementation ABCCollectDepotAddressDepot
	- (CGFloat) SizePaddingLeft {
		return 55.0f;
	}

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

		ABCPin* pin = [[ABCPin alloc] initWithText:@"B"];
		[self addSubview:pin];
		[pin setFrame:CGRectMake(
			([self SizePaddingLeft] - [ABCPin SizeViewWidth]) / 2.0f,
			([self sizeView].height - [ABCPin SizeViewHeight]) / 2.0f,
			[ABCPin SizeViewWidth],
			[ABCPin SizeViewHeight])];

		CGSize sizeThatFits = CGSizeMake(
			[self sizeView].width - [self SizePaddingLeft],
			[self sizeView].height);

		UILabel* labelAddress = [[UILabel alloc] init];
		[self addSubview:labelAddress];
		[labelAddress setFont:[AppDelegate FontRegularWithSize:8.0f]];
		[labelAddress setNumberOfLines:1];
		[labelAddress setText:[[self dataAddress] address]];
		[labelAddress setTextColor:[AppDelegate ColourAppBlack]];

		UILabel* labelTitle = [[UILabel alloc] init];
		[self addSubview:labelTitle];
		[labelTitle setFont:[AppDelegate FontRegularWithSize:10.0f]];
		[labelTitle setNumberOfLines:1];
		[labelTitle setText:NSLocalizedString(@"Your dpd depot", nil)];
		[labelTitle setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelAddressSize = [labelAddress sizeThatFits:sizeThatFits];
		CGSize labelTitleSize = [labelTitle sizeThatFits:sizeThatFits];

		[labelAddress setFrame:CGRectMake(
			[self SizePaddingLeft],
			[AppDelegate SizePaddingFromSides] + labelTitleSize.height + [AppDelegate SizePaddingFromSidesThin],
			labelAddressSize.width,
			labelAddressSize.height)];

		[labelTitle setFrame:CGRectMake(
			[self SizePaddingLeft],
			[AppDelegate SizePaddingFromSides],
			labelTitleSize.width,
			labelTitleSize.height)];
	}
@end
