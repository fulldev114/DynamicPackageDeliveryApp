//
//  ABCCollectDepot.m
//  your-dpd
//
//  Created by Richard Simkins on 15/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCCollectDepot.h"

#import "ABCConfirm.h"
#import "ABCCollectDepotAddressCollection.h"
#import "ABCCollectDepotDateCollection.h"
#import "ABCCollectDepotDirectionCollectionExpand.h"
#import "ABCCollectDepotMap.h"
#import "ABCCollectDepotNoteBringId.h"
#import "ABCCollectDepotParcel.h"
#import "ABCCollectDepotTimeslotCollection.h"
#import "ABCDataAddress.h"
#import "ABCDataDate.h"
#import "ABCDataTimeslot.h"
#import "AppDelegate.h"

@interface ABCCollectDepot()
	@property (nonatomic) ABCCollectDepotAddressCollection* addressCollection;
	@property (nonatomic) ABCConfirm* confirm;
	@property (nonatomic) ABCDataParcel* dataParcel;
	@property (nonatomic) ABCCollectDepotDateCollection* dateCollection;
	@property (nonatomic) ABCCollectDepotDirectionCollectionExpand* directionCollectionExpand;
	@property (nonatomic) ABCCollectDepotMap* map;
	@property (nonatomic) ABCCollectDepotNoteBringId* note;
	@property (nonatomic) ABCCollectDepotParcel* parcel;
	@property (nonatomic) UIScrollView* scrollView;
	@property (nonatomic) ABCCollectDepotTimeslotCollection* timeslotCollection;
@end

@implementation ABCCollectDepot
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel {
		self = [super init];

		if (!self) return nil;

		[self setDataParcel:dataParcel];

		[self setTitle:NSLocalizedString(@"Collect from DPD Depot", nil)];

		return self;
	}

	- (void) viewDidLoad {
		[super viewDidLoad];

		[self setScrollView:[[UIScrollView alloc] init]];
		[[self view] addSubview:[self scrollView]];

		[self setConfirm:[[ABCConfirm alloc]
			initWithText:NSLocalizedString(@"Confirm Changes", nil)
			andBlock:^{
				[self
					confirmWithTitle:NSLocalizedString(@"Are you sure you want to change this delivery?", nil)
					andMessage:NSLocalizedString(@"Select 'Yes' to confirm and deliver <text>?", nil)
					andBlockConfirm:^{
						[[self navigationController] popViewControllerAnimated:YES];
					}];
			}]];
		[[self view] addSubview:[self confirm]];

		[self setParcel:[[ABCCollectDepotParcel alloc] initWithDataParcel:[self dataParcel]]];
		[[self scrollView] addSubview:[self parcel]];

		[self setDateCollection:[[ABCCollectDepotDateCollection alloc] initWithDataDateCollection:@[
			[[ABCDataDate alloc] initWithNSDictionary:@{
				@"date":@"Tuesday 12 March",
			}],
			[[ABCDataDate alloc] initWithNSDictionary:@{
				@"date":@"Wednesday 13 March",
			}],
			[[ABCDataDate alloc] initWithNSDictionary:@{
				@"date":@"Thursday 14 March",
			}],
			[[ABCDataDate alloc] initWithNSDictionary:@{
				@"date":@"Friday 15 March",
			}],
		]]];
		[[self scrollView] addSubview:[self dateCollection]];

		[self setTimeslotCollection:[[ABCCollectDepotTimeslotCollection alloc] initWithDataTimeslotCollection:@[
			[[ABCDataTimeslot alloc] initWithNSDictionary:@{
				@"timeslot":@"11:00 - 12:00"
			}],
			[[ABCDataTimeslot alloc] initWithNSDictionary:@{
				@"timeslot":@"13:00 - 14:00"
			}],
			[[ABCDataTimeslot alloc] initWithNSDictionary:@{
				@"timeslot":@"15:00 - 16:00"
			}],
			[[ABCDataTimeslot alloc] initWithNSDictionary:@{
				@"timeslot":@"16:00 - 17:00"
			}],
		]]];
		[[self scrollView] addSubview:[self timeslotCollection]];

		[self setNote:[[ABCCollectDepotNoteBringId alloc] init]];
		[[self scrollView] addSubview:[self note]];

		[self setMap:[[ABCCollectDepotMap alloc] init]];
		[[self scrollView] addSubview:[self map]];

		[self setAddressCollection:[[ABCCollectDepotAddressCollection alloc]
			initWithAddressUserCollection:@[
				[[ABCDataAddress alloc] initWithNSDictionary:@{
					@"address":@"16 Weston Drive, Tipton, West Midlands, DY4 OAE",
				}]]
			andAddressDepotCollection:@[
				[[ABCDataAddress alloc] initWithNSDictionary:@{
					@"address":@"Birmingham Road, Oldbury, West Midlands, B69 48F",
				}]]]];
		[[self scrollView] addSubview:[self addressCollection]];

		[self setDirectionCollectionExpand:[[ABCCollectDepotDirectionCollectionExpand alloc] initWithBlockExpand:^(CGFloat difference) {
			[self updateStatusBarHeightChangesWithDifference:0.0f];
			[[self scrollView]
				setContentOffset:CGPointMake(
					0.0f,
					[[self scrollView] contentOffset].y + difference)
				animated:NO];
		}]];
		[[self scrollView] addSubview:[self directionCollectionExpand]];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		top += [[self parcel]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self dateCollection]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self timeslotCollection]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self note]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSidesThin];

		top += [[self map]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [[self addressCollection]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self directionCollectionExpand]
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
			[[self view] frame].size.height - [[self confirm] SizeViewHeight] + difference)];

		[[self confirm] setFrame:CGRectMake(
			0.0f,
			[[self view] frame].size.height - [[self confirm] SizeViewHeight] + difference,
			[[self confirm] SizeViewWidth],
			[[self confirm] SizeViewHeight])];
	}
@end
