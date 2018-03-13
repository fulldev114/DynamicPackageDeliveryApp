//
//  ABCDeliverNeighbourParcel.m
//  your-dpd
//
//  Created by Richard Simkins on 27/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliverNeighbourParcel.h"

#import "ABCDataStatus.h"
#import "AppDelegate.h"

@interface ABCDeliverNeighbourParcel()
	@property (nonatomic) ABCDataParcel* dataParcel;
@end

@implementation ABCDeliverNeighbourParcel
	- (CGFloat) SizePaddingBottom {
		return 14.0f;
	}

	- (CGFloat) SizePaddingLeft {
		return 70.0f;
	}

	- (CGFloat) SizePaddingRight {
		return 10.0f;
	}

	- (CGFloat) SizePaddingTop {
		return 12.0f;
	}

	- (CGFloat) SizeSeparator {
		return 5.0f;
	}

	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel {
		self = [super init];

		if (!self) return nil;

		[self setDataParcel:dataParcel];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			87.0f)];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setBackgroundColor:[UIColor whiteColor]];

		CGSize sizeThatFits = CGSizeMake(
			[self sizeView].width - [self SizePaddingLeft] - [self SizePaddingRight],
			[self sizeView].height - ([AppDelegate SizePaddingFromSidesThin] * 2.0f));

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
			[self SizePaddingTop],
			dispatcherNameSize.width,
			dispatcherNameSize.height)];

		NSAttributedString* referenceNumberText = [[NSAttributedString alloc]
			initWithString:[[self dataParcel] referenceNumber]
			attributes:@{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:12.0f],
				NSForegroundColorAttributeName:[AppDelegate ColourAppBlack],
			}];

		UILabel* referenceNumber = [[UILabel alloc] init];
		[self addSubview:referenceNumber];
		[referenceNumber setAttributedText:referenceNumberText];

		CGSize referenceNumberSize = [referenceNumber sizeThatFits:sizeThatFits];

		[referenceNumber setFrame:CGRectMake(
			[self SizePaddingLeft] + [self SizeSeparator] + dispatcherNameSize.width,
			[self SizePaddingTop] + dispatcherNameSize.height - referenceNumberSize.height,
			referenceNumberSize.width,
			referenceNumberSize.height)];

		ABCDataStatus* dataStatus = [[ABCDataStatus alloc] initWithDataParcel:[self dataParcel]];

		UILabel* description = [[UILabel alloc] init];
		[self addSubview:description];
		[description setAttributedText:[dataStatus attributedString]];
		[description setNumberOfLines:0];

		CGSize descriptionSize = [description sizeThatFits:sizeThatFits];

		[description setFrame:CGRectMake(
			[self SizePaddingLeft],
			[self sizeView].height - [self SizePaddingBottom] - descriptionSize.height,
			descriptionSize.width,
			descriptionSize.height)];

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
