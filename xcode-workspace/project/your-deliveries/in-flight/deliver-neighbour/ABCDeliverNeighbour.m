//
//  ABCDeliverNeighbour.m
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliverNeighbour.h"

#import "ABCConfirm.h"
#import "ABCDataAddress.h"
#import "ABCDeliverNeighbourAddressCollection.h"
#import "ABCDeliverNeighbourParcel.h"
#import "AppDelegate.h"

@interface ABCDeliverNeighbour()
	@property (nonatomic) ABCDeliverNeighbourAddressCollection* addressCollection;
	@property (nonatomic) ABCConfirm* confirm;
	@property (nonatomic) ABCDataParcel* dataParcel;
	@property (nonatomic) ABCDeliverNeighbourParcel* parcel;
	@property (nonatomic) UIScrollView* scrollView;
@end

@implementation ABCDeliverNeighbour
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel {
		self = [super init];

		if (!self) return nil;

		[self setDataParcel:dataParcel];

		[self setTitle:NSLocalizedString(@"Deliver to Neighbour", nil)];

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
					andMessage:NSLocalizedString(@"Select 'Yes' to confirm and deliver directly to your neighbour at 26 College Drive?", nil)
					andBlockConfirm:^{
						[[self navigationController] popViewControllerAnimated:YES];
					}];
			}]];
		[[self view] addSubview:[self confirm]];

		[self setParcel:[[ABCDeliverNeighbourParcel alloc] initWithDataParcel:[self dataParcel]]];
		[[self scrollView] addSubview:[self parcel]];

		[self setAddressCollection:[[ABCDeliverNeighbourAddressCollection alloc] initWithDataAddressCollection:@[
			[[ABCDataAddress alloc] initWithNSDictionary:@{
				@"address":@"23 College Drive, Manchester"
			}],
			[[ABCDataAddress alloc] initWithNSDictionary:@{
				@"address":@"25 College Drive, Manchester"
			}],
			[[ABCDataAddress alloc] initWithNSDictionary:@{
				@"address":@"26 College Drive, Manchester"
			}],
			[[ABCDataAddress alloc] initWithNSDictionary:@{
				@"address":@"27 College Drive, Manchester"
			}],
			[[ABCDataAddress alloc] initWithNSDictionary:@{
				@"address":@"28 College Drive, Manchester"
			}],
		]]];
		[[self scrollView] addSubview:[self addressCollection]];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		top += [[self parcel]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self addressCollection]
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
