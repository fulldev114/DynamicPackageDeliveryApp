//
//  ABCCollectShop.m
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCCollectShop.h"

#import "ABCCollectShopDetailCollection.h"
#import "ABCCollectShopLoadMore.h"
#import "ABCCollectShopMap.h"
#import "ABCCollectShopParcel.h"
#import "ABCConfirm.h"
#import "ABCDataShop.h"
#import "AppDelegate.h"

@interface ABCCollectShop()
	@property (nonatomic) ABCConfirm* confirm;
	@property (nonatomic) ABCDataParcel* dataParcel;
	@property (nonatomic) ABCCollectShopLoadMore* loadMore;
	@property (nonatomic) ABCCollectShopMap* map;
	@property (nonatomic) ABCCollectShopParcel* parcel;
	@property (nonatomic) UIScrollView* scrollView;
	@property (nonatomic) ABCCollectShopDetailCollection* shopCollection;
@end

@implementation ABCCollectShop
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel {
		self = [super init];

		if (!self) return nil;

		[self setDataParcel:dataParcel];

		[self setTitle:NSLocalizedString(@"Collect from Local Shop", nil)];

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
					andMessage:NSLocalizedString(@"Select 'Yes' to confirm and deliver directly to Rowlands Pharmacy?", nil)
					andBlockConfirm:^{
						[[self navigationController] popViewControllerAnimated:YES];
					}];
			}]];
		[[self view] addSubview:[self confirm]];

		[self setParcel:[[ABCCollectShopParcel alloc] initWithDataParcel:[self dataParcel]]];
		[[self scrollView] addSubview:[self parcel]];

		[self setShopCollection:[[ABCCollectShopDetailCollection alloc] initWithDataShopCollection:@[
			[[ABCDataShop alloc] initWithNSDictionary:@{
				@"address_single_line":@"White City Retail Park",
				@"distance_miles":@"1.0",
				@"place_name":@"Halfords",
			}],
			[[ABCDataShop alloc] initWithNSDictionary:@{
				@"address_single_line":@"1 Lime Grove",
				@"distance_miles":@"1.2",
				@"place_name":@"Rowlands Pharmacy",
			}],
			[[ABCDataShop alloc] initWithNSDictionary:@{
				@"address_single_line":@"117b Withington Road",
				@"distance_miles":@"1.4",
				@"place_name":@"Numark Pharmacy",
			}],
		]]];
		[[self scrollView] addSubview:[self shopCollection]];

		[self setLoadMore:[[ABCCollectShopLoadMore alloc]
			initWithText:NSLocalizedString(@"Load More Shops", nil)
			andBlockLoadMore:^{
				NSLog(@"Load more shops");
			}]];
		[[self scrollView] addSubview:[self loadMore]];

		[self setMap:[[ABCCollectShopMap alloc] init]];
		[[self scrollView] addSubview:[self map]];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		top += [[self parcel]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSidesThin];

		top += [[self shopCollection]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self loadMore]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top	+= [AppDelegate SizePaddingFromSides];

		top += [[self map]
			setPositionX:0.0f
			andPositionY:top];

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
