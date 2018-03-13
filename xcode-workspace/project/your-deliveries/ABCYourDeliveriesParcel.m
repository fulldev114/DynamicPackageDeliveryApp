//
//  ABCYourDeliveriesParcel.m
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourDeliveriesParcel.h"

#import "ABCDataStatus.h"
#import "AppDelegate.h"

@interface ABCYourDeliveriesParcel()
	@property (nonatomic) ABCDataParcel* dataParcel;
@end

@implementation ABCYourDeliveriesParcel
	- (CGFloat) SizePaddingHorizontal {
		return 14.0f;
	}

	- (CGFloat) SizePaddingLeft {
		return 70.0f;
	}

	- (CGFloat) SizePaddingRight {
		return 35.0f;
	}

	- (CGFloat) SizeSeparator {
		return 5.0f;
	}

	- (instancetype)
		initWithDataParcel:(ABCDataParcel*)dataParcel
		andSizeView:(CGSize)sizeView {

		self = [super init];

		if (!self) return nil;

		[self setDataParcel:dataParcel];
		[self setSizeView:sizeView];
		[self initialise];

		return self;
	}

	- (void) initialise {
		CGSize sizeThatFits = CGSizeMake(
			[self sizeView].width - [self SizePaddingLeft] - [self SizePaddingRight],
			[self sizeView].height - ([AppDelegate SizePaddingFromSidesThin] * 2.0f));

		UIView* horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(
			0.0f,
			0.0f,
			[self sizeView].width,
			[AppDelegate SizeSeparationThickness])];
		[self addSubview:horizontalLine];
		[horizontalLine setBackgroundColor:[AppDelegate ColourAppGreyLight]];

		NSAttributedString* dispatcherNameText = [[NSAttributedString alloc]
			initWithString:[[self dataParcel] dispatcherName]
			attributes:@{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:12.0f],
				NSForegroundColorAttributeName:[AppDelegate ColourAppBlack],
			}];

		UILabel* dispatcherName = [[UILabel alloc] init];
		[self addSubview:dispatcherName];
		[dispatcherName setAttributedText:dispatcherNameText];

		CGSize dispatcherNameSize = [dispatcherName sizeThatFits:sizeThatFits];

		[dispatcherName setFrame:CGRectMake(
			[self SizePaddingLeft],
			[self SizePaddingHorizontal],
			dispatcherNameSize.width,
			dispatcherNameSize.height)];

		NSAttributedString* referenceNumberText = [[NSAttributedString alloc]
			initWithString:[[self dataParcel] referenceNumber]
			attributes:@{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:9.0f],
				NSForegroundColorAttributeName:[AppDelegate ColourAppBlack],
			}];

		UILabel* referenceNumber = [[UILabel alloc] init];
		[self addSubview:referenceNumber];
		[referenceNumber setAttributedText:referenceNumberText];

		CGSize referenceNumberSize = [referenceNumber sizeThatFits:sizeThatFits];

		[referenceNumber setFrame:CGRectMake(
			[self SizePaddingLeft] + [self SizeSeparator] + dispatcherNameSize.width,
			[self SizePaddingHorizontal] + dispatcherNameSize.height - referenceNumberSize.height,
			referenceNumberSize.width,
			referenceNumberSize.height)];

		ABCDataStatus* dataStatus;

/*		if ([[[self dataParcel] type] isEqualToString:@""]) {
			dataStatus = [[ABCDataStatus alloc] initWithNSDictionary:@{
				@"type":@"delivery_in_past",
				@"data_parcel":[self dataParcel],
			}];
		} else if ([[[self dataParcel] type] isEqualToString:@""]) {
			dataStatus = [[ABCDataStatus alloc] initWithNSDictionary:@{
				@"type":@"delivery_today",
				@"data_parcel":[self dataParcel],
			}];
		}*/
		dataStatus = [[ABCDataStatus alloc] initWithDataParcel:[self dataParcel]];

		[dataStatus setFontSize:10.0f];
		[dataStatus setHighlight:NO];
		UILabel* description = [[UILabel alloc] init];
		[self addSubview:description];
		[description setAttributedText:[dataStatus attributedString]];
		[description setNumberOfLines:0];

		CGSize descriptionSize = [description sizeThatFits:sizeThatFits];

		[description setFrame:CGRectMake(
			[self SizePaddingLeft],
			[self sizeView].height - [self SizePaddingHorizontal] - descriptionSize.height,
			descriptionSize.width,
			descriptionSize.height)];

		UIImageView* arrow = [[UIImageView alloc] initWithFrame:CGRectMake(
			[self sizeView].width - [AppDelegate SizeIcon25],
			([self sizeView].height - [AppDelegate SizeIcon25]) / 2.0f,
			[AppDelegate SizeIcon25],
			[AppDelegate SizeIcon25])];
		[self addSubview:arrow];
		[arrow setContentMode:UIViewContentModeScaleAspectFill];
		[arrow setImage:[UIImage imageNamed:@"parcel-arrow.png"]];

		UIImageView* icon = [[UIImageView alloc] initWithFrame:CGRectMake(
			([self SizePaddingLeft] - [AppDelegate SizeIcon40]) / 2.0f,
			([self sizeView].height - [AppDelegate SizeIcon40]) / 2.0f,
			[AppDelegate SizeIcon40],
			[AppDelegate SizeIcon40])];
		[self addSubview:icon];
		[icon setContentMode:UIViewContentModeScaleAspectFill];
		[icon setImage:[UIImage imageNamed:@"parcel-dispatcher-placeholder.png"]];
	}
@end
