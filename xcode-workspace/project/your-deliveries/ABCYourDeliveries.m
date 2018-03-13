//
//  ABCYourDeliveries.m
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourDeliveries.h"

#import "ABCDataParcel.h"
#import "ABCDeliveryComplete.h"
#import "ABCDeliveryToday.h"
#import "ABCDeliveryToDepot.h"
#import "ABCYourDeliveriesAlertNotifications.h"
#import "ABCYourDeliveriesParcelCollection.h"
#import "AppDelegate.h"

@interface ABCYourDeliveries()
	@property (nonatomic) NSArray* dataParcelActiveCollection;
	@property (nonatomic) NSArray* dataParcelPreviousCollection;
	@property (nonatomic) ABCYourDeliveriesAlertNotifications* notifications;
	@property (nonatomic) ABCYourDeliveriesParcelCollection* parcelCollection;
	@property (nonatomic) UIScrollView* scrollView;
@end

@implementation ABCYourDeliveries
	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setDataParcelActiveCollection:@[
			[[ABCDataParcel alloc] initWithNSDictionary:@{
				@"dispatcher_name":@"ASOS",
				@"driver_name":@"Brian",
				@"reference_number":@"12345678987654",
				@"time_delivery_estimate":@"10:03-11:03",
				@"status":@"delivery-today",
			}],
			[[ABCDataParcel alloc] initWithNSDictionary:@{
				@"depot_address":@"16 Weston Drive, Tipton, West Midlands, DY4 OAE",
				@"dispatcher_name": @"ASOS",
				@"reference_number": @"12345678987654",
				@"time_delivery_depot_on_day": @"13/03/15",
				@"time_delivery_depot_from_time": @"14:00",
				@"status":@"delivery-to-depot",
			}],
		]];
		[self setDataParcelPreviousCollection:@[
			[[ABCDataParcel alloc] initWithNSDictionary:@{
				@"dispatcher_name": @"EE",
				@"collector_name": @"SMITH",
				@"reference_number": @"12345678987654",
				@"time_delivery_complete": @"09/03/2015",
				@"status":@"delivery-complete",
			}],
			[[ABCDataParcel alloc] initWithNSDictionary:@{
				@"collector_name": @"SMITH",
				@"reference_number": @"12345678987654",
				@"time_delivery_complete": @"09/03/2015",
				@"status":@"delivery-complete",
			}],
			[[ABCDataParcel alloc] initWithNSDictionary:@{
				@"dispatcher_name": @"M&S",
				@"collector_name": @"SMITH",
				@"reference_number": @"12345678987654",
				@"time_delivery_complete": @"07/03/2015",
				@"status":@"delivery-complete",
			}],
			[[ABCDataParcel alloc] initWithNSDictionary:@{
				@"collector_name": @"SMITH",
				@"reference_number": @"12345678987654",
				@"time_delivery_complete": @"05/03/2015",
				@"status":@"delivery-complete",
			}],
		]];

		return self;
	}

	- (void) viewDidLoad {
		[super viewDidLoad];

		[self setScrollView:[[UIScrollView alloc] init]];
		[[self view] addSubview:[self scrollView]];

		[self setNotifications:[[ABCYourDeliveriesAlertNotifications alloc] init]];
		[[self scrollView] addSubview:[self notifications]];

		[self setParcelCollection:[[ABCYourDeliveriesParcelCollection alloc]
			initWithActiveDeliveries:[self dataParcelActiveCollection]
			andPreviousDeliveries:[self dataParcelPreviousCollection]
			andBlockActiveRowSelect:^(ABCDataParcel* dataParcel) {
				if ([[dataParcel status] isEqualToString:@"delivery-today"]) {
					ABCDeliveryToday* viewController = [[ABCDeliveryToday alloc] initWithDataParcel:dataParcel];
					[[self navigationController]
						pushViewController:viewController
						animated:YES];
				} else if ([[dataParcel status] isEqualToString:@"delivery-to-depot"]) {
					ABCDeliveryToDepot* viewController = [[ABCDeliveryToDepot alloc] initWithDataParcel:dataParcel];
					[[self navigationController]
						pushViewController:viewController
						animated:YES];
				}
			}
			andBlockPreviousRowSelect:^(ABCDataParcel *dataParcel) {
				ABCDeliveryComplete* viewController = [[ABCDeliveryComplete alloc] initWithDataParcel:dataParcel];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];
		[[self scrollView] addSubview:[self parcelCollection]];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		top += [[self notifications]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSidesThin];

		top += [[self parcelCollection]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		[[self scrollView] setContentSize:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width,
			top)];
		[[self scrollView] setFrame:CGRectMake(
			0.0f,
			0.0f,
			[[UIScreen mainScreen] bounds].size.width,
			[[self view] frame].size.height + difference)];
	}
@end
