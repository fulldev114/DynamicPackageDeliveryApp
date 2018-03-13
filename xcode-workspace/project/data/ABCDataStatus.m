//
//  ABCDataStatus.m
//  your-dpd
//
//  Created by Richard Simkins on 18/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDataStatus.h"

#import "AppDelegate.h"

@interface ABCDataStatus()
	@property (nonatomic) ABCDataParcel* dataParcel;
@end

@implementation ABCDataStatus
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel {
		self = [super init];

		if (!self) return nil;

		[self setDataParcel:dataParcel];
		[self setFontSize:12.0f];
		[self setHighlight:YES];

		return self;
	}

	- (NSAttributedString*) attributedString {
		NSAttributedString* attrubutedString;

		if ([[[self dataParcel] status] isEqualToString:@"delivery-complete"]) {
			attrubutedString = [self deliveryComplete];
		} else if ([[[self dataParcel] status] isEqualToString:@"delivery-today"]) {
			attrubutedString = [self deliveryToday];
		} else if ([[[self dataParcel] status] isEqualToString:@"delivery-to-depot"]) {
			attrubutedString = [self deliveryToDepot];
		}

		return attrubutedString;
	}

	- (NSAttributedString*) deliveryComplete {
		NSMutableAttributedString* attributedString;

		if ([self highlight]) {
			NSString* part1 = NSLocalizedString(@"Delivered to your safe place on ", nil);

			attributedString = [[NSMutableAttributedString alloc]
				initWithString:[NSString
					stringWithFormat:@"%@%@",
					part1,
					[[self dataParcel] timeDeliveryComplete]]
				attributes:@{
					NSFontAttributeName:[AppDelegate FontRegularWithSize:[self fontSize]],
					NSForegroundColorAttributeName:[AppDelegate ColourAppBlack],
				}];
			[attributedString
				setAttributes:@{
					NSFontAttributeName:[AppDelegate FontRegularWithSize:[self fontSize]],
					NSForegroundColorAttributeName:[AppDelegate ColourAppRed],
				}
				range:NSMakeRange([part1 length], [[[self dataParcel] timeDeliveryComplete] length])];
		} else {
			NSString* part1 = NSLocalizedString(@"The parcel has been delivered, signed for by ", nil);
			NSString* part2 = NSLocalizedString(@", on ", nil);

			attributedString = [[NSMutableAttributedString alloc]
				initWithString:[NSString
					stringWithFormat:@"%@%@%@%@",
					part1,
					[[self dataParcel] collectorName],
					part2,
					[[self dataParcel] timeDeliveryComplete]]
				attributes:@{
					NSFontAttributeName:[AppDelegate FontRegularWithSize:[self fontSize]],
					NSForegroundColorAttributeName:[AppDelegate ColourAppBlack],
				}];
		}

		return attributedString;
	}

	- (NSAttributedString*) deliveryToday {
		NSMutableAttributedString* attributedString;

		NSString* part1 = NSLocalizedString(@"Your ", nil);
		NSString* part2 = NSLocalizedString(@" order will be delivered today by ", nil);
		NSString* part3 = NSLocalizedString(@", your DPD driver,", nil);
		NSString* part4 = NSLocalizedString(@" between ", nil);

		attributedString = [[NSMutableAttributedString alloc]
			initWithString:[NSString
				stringWithFormat:@"%@%@%@%@%@%@%@",
				part1,
				[[self dataParcel] dispatcherName],
				part2,
				[[self dataParcel] driverName],
				[self highlight] ? part3 : @"",
				part4,
				[[self dataParcel] timeDeliveryEstimate]]
			attributes:@{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:[self fontSize]],
				NSForegroundColorAttributeName:[AppDelegate ColourAppBlack],
			}];

		if ([self highlight]) {
			NSDictionary* attributes = @{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:[self fontSize]],
				NSForegroundColorAttributeName:[AppDelegate ColourAppRed],
			};
			NSUInteger dispatcherNameLength = [[[self dataParcel] dispatcherName] length];
			NSUInteger driverNameLength = [[[self dataParcel] driverName] length];
			NSUInteger timeDeliveryEstimateLength = [[[self dataParcel] timeDeliveryEstimate] length];
			[attributedString
				setAttributes:attributes
				range:NSMakeRange([part1 length] + dispatcherNameLength + [part2 length], driverNameLength)];
			[attributedString
				setAttributes:attributes
				range:NSMakeRange([part1 length] + dispatcherNameLength + [part2 length] + driverNameLength + [part3 length] + [part4 length], timeDeliveryEstimateLength)];
		}

		return attributedString;
	}

	- (NSAttributedString*) deliveryToDepot {
		NSMutableAttributedString* attributedString;

		NSString* part1 = NSLocalizedString(@"Your ", nil);
		NSString* part2 = NSLocalizedString(@" parcel is due for collection at the DPD depot on ", nil);
		NSString* part3 = NSLocalizedString(@" at ", nil);

		attributedString = [[NSMutableAttributedString alloc]
			initWithString:[NSString
				stringWithFormat:@"%@%@%@%@%@%@",
				part1,
				[[self dataParcel] dispatcherName],
				part2,
				[[self dataParcel] timeDeliveryOnDay],
				part3,
				[[self dataParcel] timeDeliveryFromTime]]
			attributes:@{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:[self fontSize]],
				NSForegroundColorAttributeName:[AppDelegate ColourAppBlack],
			}];

		if ([self highlight]) {
			NSDictionary* attributes = @{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:[self fontSize]],
				NSForegroundColorAttributeName:[AppDelegate ColourAppRed],
			};
			NSUInteger dispatcherNameLength = [[[self dataParcel] dispatcherName] length];
			NSUInteger timeDeliveryOnDayLength = [[[self dataParcel] timeDeliveryOnDay] length];
			NSUInteger timeDeliveryFromTimeLength = [[[self dataParcel] timeDeliveryFromTime] length];
			[attributedString
				setAttributes:attributes
				range:NSMakeRange([part1 length] + dispatcherNameLength + [part2 length], timeDeliveryOnDayLength)];
			[attributedString
				setAttributes:attributes
				range:NSMakeRange([part1 length] + dispatcherNameLength + [part2 length] + timeDeliveryOnDayLength + [part3 length], timeDeliveryFromTimeLength)];
		}

		return attributedString;
	}
@end
