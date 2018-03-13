//
//  ABCCollectShopDetail.m
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCCollectShopDetail.h"

#import "AppDelegate.h"
#import "ABCPin.h"

@interface ABCCollectShopDetail()
	@property (nonatomic, strong) BlockShopSelect blockShopSelect;
	@property (nonatomic, strong) BlockShopTimes blockShopTimes;
	@property (nonatomic) ABCDataShop* dataShop;
	@property (nonatomic) NSUInteger index;
@end

@implementation ABCCollectShopDetail
	- (CGFloat) SizeButtonTimesHeight {
		return 40.0f;
	}

	- (CGFloat) SizePaddingVertical {
		return 61.0f;
	}

	- (instancetype)
		initWithDataShop:(ABCDataShop*)dataShop
		andIndex:(NSUInteger)index
		andSizeView:(CGSize)sizeView
		andBlockShopSelect:(BlockShopSelect)blockShopSelect
		andBlockShopTimes:(BlockShopTimes)blockShopTimes {

		self = [super init];

		if (!self) return nil;

		[self setBlockShopSelect:blockShopSelect];
		[self setBlockShopTimes:blockShopTimes];
		[self setDataShop:dataShop];
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

		CGSize sizeToFit = CGSizeMake(
			[self sizeView].width - ([self SizePaddingVertical] * 2.0f),
			[self sizeView].height);
		CGFloat top = [AppDelegate SizePaddingFromSides];

		UILabel* labelPlaceName = [[UILabel alloc] init];
		[self addSubview:labelPlaceName];
		[labelPlaceName setFont:[AppDelegate FontRegularWithSize:16.0f]];
		[labelPlaceName setNumberOfLines:1];
		[labelPlaceName setText:[[self dataShop] placeName]];
		[labelPlaceName setTextColor:[AppDelegate ColourAppBlack]];

		CGSize sizePlaceName = [labelPlaceName sizeThatFits:sizeToFit];

		[labelPlaceName setFrame:CGRectMake(
			[self SizePaddingVertical],
			top,
			sizePlaceName.width,
			sizePlaceName.height)];

		top += sizePlaceName.height;
		top += [AppDelegate SizePaddingFromSidesThin];

		UILabel* labelAddress = [[UILabel alloc] init];
		[self addSubview:labelAddress];
		[labelAddress setFont:[AppDelegate FontRegularWithSize:16.0f]];
		[labelAddress setNumberOfLines:1];
		[labelAddress setText:[[self dataShop] addressSingleLine]];
		[labelAddress setTextColor:[AppDelegate ColourAppBlack]];

		CGSize sizeAddress = [labelAddress sizeThatFits:sizeToFit];

		[labelAddress setFrame:CGRectMake(
			[self SizePaddingVertical],
			top,
			sizeAddress.width,
			sizeAddress.height)];

		top += sizeAddress.height;

		UILabel* labelDistance = [[UILabel alloc] init];
		[self addSubview:labelDistance];
		[labelDistance setFont:[AppDelegate FontRegularWithSize:16.0f]];
		[labelDistance setNumberOfLines:1];
		[labelDistance setText:[NSString stringWithFormat:@"%@ miles away", [[self dataShop] distanceMiles]]];
		[labelDistance setTextColor:[AppDelegate ColourAppBlack]];

		CGSize sizeDistance = [labelDistance sizeThatFits:sizeToFit];

		[labelDistance setFrame:CGRectMake(
			[self SizePaddingVertical],
			top,
			sizeDistance.width,
			sizeDistance.height)];

		UILabel* labelTimes = [[UILabel alloc] init];
		[self addSubview:labelTimes];
		[labelTimes setFont:[AppDelegate FontRegularWithSize:16.0f]];
		[labelTimes setNumberOfLines:1];
		[labelTimes setText:NSLocalizedString(@"Shop opening hours", nil)];
		[labelTimes setTextColor:[AppDelegate ColourAppBlack]];

		CGSize sizeTimes = [labelTimes sizeThatFits:sizeToFit];

		[labelTimes setFrame:CGRectMake(
			[self SizePaddingVertical],
			([self sizeView].height - [self SizeButtonTimesHeight]) + (([self SizeButtonTimesHeight] - sizeTimes.height) / 2.0f),
			sizeTimes.width,
			sizeTimes.height)];

		UIImageView* clock = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clock.png"]];
		[self addSubview:clock];
		[clock setFrame:CGRectMake(
			([self SizePaddingVertical] - [AppDelegate SizeIcon25]) / 2.0f,
			([self sizeView].height - [self SizeButtonTimesHeight]) + (([self SizeButtonTimesHeight] - [AppDelegate SizeIcon25]) / 2.0f),
			[AppDelegate SizeIcon25],
			[AppDelegate SizeIcon25])];

		ABCPin* pin = [[ABCPin alloc] initWithIndex:[self index]];
		[self addSubview:pin];
		[pin setFrame:CGRectMake(
			([self SizePaddingVertical] - [ABCPin SizeViewWidth]) / 2.0f,
			[AppDelegate SizePaddingFromSides],
			[ABCPin SizeViewWidth],
			[ABCPin SizeViewHeight])];

		[self setRadio:[[ABCRadio alloc] init]];
		[self addSubview:[self radio]];
		[[self radio] setFrame:CGRectMake(
			([self sizeView].width - [self SizePaddingVertical]) + (([self SizePaddingVertical] - [[self radio] SizeView]) / 2.0f),
			([self sizeView].height - [[self radio] SizeView]) / 2.0f,
			[[self radio] SizeView],
			[[self radio] SizeView])];

		UIButton* button;
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		[self addSubview:button];
		[button
			addTarget:self
			action:@selector(tapSelect)
			forControlEvents:UIControlEventTouchUpInside];
		[button setFrame:CGRectMake(
			0.0f,
			0.0f,
			[self sizeView].width,
			[self sizeView].height - [self SizeButtonTimesHeight])];

		button = [UIButton buttonWithType:UIButtonTypeCustom];
		[self addSubview:button];
		[button
			addTarget:self
			action:@selector(tapTimes)
			forControlEvents:UIControlEventTouchUpInside];
		[button setFrame:CGRectMake(
			0.0f,
			[self sizeView].height - [self SizeButtonTimesHeight],
			[self sizeView].width,
			[self SizeButtonTimesHeight])];
	}

	- (void) tapSelect {
		[self blockShopSelect]([self dataShop]);
	}

	- (void) tapTimes {
		[self blockShopTimes]([self dataShop]);
	}
@end
