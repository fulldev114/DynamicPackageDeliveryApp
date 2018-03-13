//
//  ABCDeliveryToDepot.m
//  your-dpd
//
//  Created by Richard Simkins on 20/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryToDepot.h"

#import "ABCDeliveryToDepotMap.h"
#import "ABCDeliveryToDepotNoteBringId.h"
#import "ABCDeliveryToDepotParcel.h"
#import "ABCDeliveryToDepotDirectionCollectionExpand.h"
#import "ABCParcelDetailLocationCollectionExpand.h"
#import "ABCParcelDetailOptionCollectionExpand.h"
#import "AppDelegate.h"

@interface ABCDeliveryToDepot()
	@property (nonatomic) ABCDataParcel* dataParcel;
	@property (nonatomic) ABCDeliveryToDepotDirectionCollectionExpand* directionCollectionExpand;
	@property (nonatomic) ABCParcelDetailLocationCollectionExpand* locationCollectionExpand;
	@property (nonatomic) ABCDeliveryToDepotMap* map;
	@property (nonatomic) ABCDeliveryToDepotNoteBringId* note;
	@property (nonatomic) ABCParcelDetailOptionCollectionExpand* optionCollectionExpand;
	@property (nonatomic) ABCDeliveryToDepotParcel* parcel;
	@property (nonatomic) UIScrollView* scrollView;
@end

@implementation ABCDeliveryToDepot
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel {
		self = [super init];

		if (!self) return nil;

		[self setTitle:NSLocalizedString(@"Your deliveries", nil)];
		[self setDataParcel:dataParcel];

		return self;
	}

	- (void) viewDidLoad {
		[super viewDidLoad];

		[self setScrollView:[[UIScrollView alloc] init]];
		[[self view] addSubview:[self scrollView]];

		[self setParcel:[[ABCDeliveryToDepotParcel alloc] initWithDataParcel:[self dataParcel]]];
		[[self scrollView] addSubview:[self parcel]];

		[self setNote:[[ABCDeliveryToDepotNoteBringId alloc] init]];
		[[self scrollView] addSubview:[self note]];

		[self setMap:[[ABCDeliveryToDepotMap alloc] init]];
		[[self scrollView] addSubview:[self map]];

		[self setDirectionCollectionExpand:[[ABCDeliveryToDepotDirectionCollectionExpand alloc] initWithBlockExpand:^(CGFloat difference) {
			[self updateStatusBarHeightChangesWithDifference:0.0f];
			[[self scrollView]
				setContentOffset:CGPointMake(
					0.0f,
					[[self scrollView] contentOffset].y + difference)
				animated:NO];
		}]];
		[[self scrollView] addSubview:[self directionCollectionExpand]];

		[self setOptionCollectionExpand:[[ABCParcelDetailOptionCollectionExpand alloc]
			initWithNavigationController:[self navigationController]
			andDataParcel:[self dataParcel]
			andBlockExpand:^(CGFloat difference) {
				[self updateStatusBarHeightChangesWithDifference:0.0f];
				[[self scrollView]
					setContentOffset:CGPointMake(
						0.0f,
						[[self scrollView] contentOffset].y + difference)
					animated:NO];
			}]];
		[[self scrollView] addSubview:[self optionCollectionExpand]];

		[self setLocationCollectionExpand:[[ABCParcelDetailLocationCollectionExpand alloc] initWithBlockExpand:^(CGFloat difference) {
			[self updateStatusBarHeightChangesWithDifference:0.0f];
			[[self scrollView]
				setContentOffset:CGPointMake(
					0.0f,
					[[self scrollView] contentOffset].y + difference)
				animated:NO];
		}]];
		[[self scrollView] addSubview:[self locationCollectionExpand]];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		top += [[self parcel]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSidesThin];

		top += [[self note]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSidesThin];

		top += [[self map]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [[self directionCollectionExpand]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self optionCollectionExpand]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self locationCollectionExpand]
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
