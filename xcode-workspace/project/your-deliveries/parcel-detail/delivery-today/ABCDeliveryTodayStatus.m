//
//  ABCDeliveryTodayStatus.m
//  your-dpd
//
//  Created by Richard Simkins on 11/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryTodayStatus.h"

#import "AppDelegate.h"

@interface ABCDeliveryTodayStatus()
	@property (nonatomic) ABCDataParcel* dataParcel;
@end

@implementation ABCDeliveryTodayStatus
	- (CGFloat) SizePaddingHorizontal {
		return 18.0f;
	}

	- (CGFloat) SizePaddingVertical {
		return 14.0f;
	}

	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel {
		self = [super init];

		if (!self) return nil;

		[self setDataParcel:dataParcel];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			86.0f)];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setBackgroundColor:[UIColor whiteColor]];

		[self setupDeliveryNumber];
		[self setupEta];
	}

	- (void) setupDeliveryNumber {
		NSString* deliveryNumberCurrent = @"50";
		NSString* deliveryNumberYours = @"56";

		NSString* part1 = NSLocalizedString(@" is currently making delivery ", nil);
		NSString* part2 = NSLocalizedString(@"number ", nil);
		NSString* part3 = NSLocalizedString(@", you are delivery ", nil);

		NSMutableAttributedString* deliveryNumberText = [[NSMutableAttributedString alloc]
			initWithString:[NSString
				stringWithFormat:@"%@%@%@%@%@%@%@",
				[[self dataParcel] driverName],
				part1,
				part2,
				deliveryNumberCurrent,
				part3,
				part2,
				deliveryNumberYours]
			attributes:@{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:10.0f],
				NSForegroundColorAttributeName:[AppDelegate ColourAppBlack],
			}];
		NSDictionary* attributes = @{
			NSFontAttributeName:[AppDelegate FontRegularWithSize:10.0f],
			NSForegroundColorAttributeName:[AppDelegate ColourAppRed],
		};

		NSUInteger driverNameLength = [[[self dataParcel] driverName] length];
		NSUInteger deliveryNumberCurrentLength = [part2 length] + [deliveryNumberCurrent length];
		NSUInteger deliveryNumberYoursLength = [part2 length] + [deliveryNumberCurrent length];

		[deliveryNumberText
			setAttributes:attributes
			range:NSMakeRange(driverNameLength + [part1 length], deliveryNumberCurrentLength)];
		[deliveryNumberText
			setAttributes:attributes
			range:NSMakeRange(driverNameLength + [part1 length] + deliveryNumberCurrentLength + [part3 length], deliveryNumberYoursLength)];

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setAttributedText:deliveryNumberText];
		[label setNumberOfLines:2];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self sizeView].width - ([self SizePaddingVertical] * 2.0f),
			[self sizeView].height - ([self SizePaddingHorizontal] * 2.0f))];

		[label setFrame:CGRectMake(
			[self SizePaddingVertical],
			[self SizePaddingHorizontal],
			labelSize.width,
			labelSize.height)];
	}

	- (void) setupEta {
		NSString* etaCurrent = @"50";

		NSString* part1 = NSLocalizedString(@" is approximately ", nil);
		NSString* part2 = NSLocalizedString(@" minutes", nil);
		NSString* part3 = NSLocalizedString(@" away from you.", nil);

		NSMutableAttributedString* etaText = [[NSMutableAttributedString alloc]
			initWithString:[NSString
				stringWithFormat:@"%@%@%@%@%@",
				[[self dataParcel] driverName],
				part1,
				etaCurrent,
				part2,
				part3]
			attributes:@{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:10.0f],
				NSForegroundColorAttributeName:[AppDelegate ColourAppBlack],
			}];
		NSDictionary* attributes = @{
			NSFontAttributeName:[AppDelegate FontRegularWithSize:10.0f],
			NSForegroundColorAttributeName:[AppDelegate ColourAppRed],
		};

		NSUInteger driverNameLength = [[[self dataParcel] driverName] length];
		NSUInteger etaCurrentLength = [etaCurrent length] + [part2 length];

		[etaText
			setAttributes:attributes
			range:NSMakeRange(driverNameLength + [part1 length], etaCurrentLength)];

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setAttributedText:etaText];
		[label setNumberOfLines:2];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self sizeView].width - ([self SizePaddingVertical] * 2.0f),
			[self sizeView].height - ([self SizePaddingHorizontal] * 2.0f))];

		[label setFrame:CGRectMake(
			[self SizePaddingVertical],
			[self sizeView].height - [self SizePaddingHorizontal] - labelSize.height,
			labelSize.width,
			labelSize.height)];
	}
@end
