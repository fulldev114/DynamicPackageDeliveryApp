//
//  ABCDeliverDate.m
//  your-dpd
//
//  Created by Richard Simkins on 15/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliverDate.h"

#import "ABCConfirm.h"
#import "ABCDataDate.h"
#import "ABCDeliverDateDetailCollection.h"
#import "ABCDeliverDateParcel.h"
#import "AppDelegate.h"

@interface ABCDeliverDate()
	@property (nonatomic) ABCConfirm* confirm;
	@property (nonatomic) ABCDataParcel* dataParcel;
	@property (nonatomic) ABCDeliverDateDetailCollection* detailCollection;
	@property (nonatomic) ABCDeliverDateParcel* parcel;
	@property (nonatomic) UIScrollView* scrollView;
@end

@implementation ABCDeliverDate
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel {
		self = [super init];

		if (!self) return nil;

		[self setDataParcel:dataParcel];

		[self setTitle:NSLocalizedString(@"Change Delivery Date", nil)];

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

		[self setParcel:[[ABCDeliverDateParcel alloc] initWithDataParcel:[self dataParcel]]];
		[[self scrollView] addSubview:[self parcel]];

		[self setDetailCollection:[[ABCDeliverDateDetailCollection alloc] initWithDataDateCollection:@[
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
		[[self scrollView] addSubview:[self detailCollection]];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		top += [[self parcel]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self detailCollection]
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
