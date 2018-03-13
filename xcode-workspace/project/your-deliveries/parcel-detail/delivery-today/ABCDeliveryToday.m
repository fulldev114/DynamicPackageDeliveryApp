//
//  ABCDeliveryToday.m
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryToday.h"

#import "ABCDataParcelLocation.h"
#import "ABCDeliveryTodayDropOffChoice.h"
#import "ABCDeliveryTodayMap.h"
#import "ABCDeliveryTodayMapKey.h"
#import "ABCDeliveryTodayParcel.h"
#import "ABCDeliveryTodayStatus.h"
#import "ABCOptionExpand.h"
#import "ABCParcelDetailAlertLocation.h"
#import "ABCParcelDetailLiveIssueSnow.h"
#import "ABCParcelDetailLocationCollectionExpand.h"
#import "ABCParcelDetailOptionCollectionExpand.h"
#import "AppDelegate.h"

@interface ABCDeliveryToday()
	@property (nonatomic) ABCParcelDetailAlertLocation* alertLocation;
	@property (nonatomic) ABCDataParcel* dataParcel;
	@property (nonatomic) ABCDeliveryTodayDropOffChoice* dropOffChoice;
	@property (nonatomic) ABCParcelDetailLiveIssueSnow* liveIssue;
	@property (nonatomic) ABCParcelDetailLocationCollectionExpand* locationCollectionExpand;
	@property (nonatomic) ABCParcelDetailOptionCollectionExpand* optionCollectionExpand;
	@property (nonatomic) ABCDeliveryTodayMap* map;
	@property (nonatomic) ABCDeliveryTodayMapKey* mapKey;
	@property (nonatomic) ABCDeliveryTodayParcel* parcel;
	@property (nonatomic) UIScrollView* scrollView;
	@property (nonatomic) ABCDeliveryTodayStatus* status;
	@property (nonatomic) ABCOptionExpand* statusExpand;
	@property (nonatomic) BOOL statusExpandDisable;
@end

@implementation ABCDeliveryToday
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

		[self setParcel:[[ABCDeliveryTodayParcel alloc] initWithDataParcel:[self dataParcel]]];
		[[self scrollView] addSubview:[self parcel]];

		[self setLiveIssue:[[ABCParcelDetailLiveIssueSnow alloc] init]];
		[[self scrollView] addSubview:[self liveIssue]];

		[self setStatusExpand:[[ABCOptionExpand alloc]
			initWithText:[NSString stringWithFormat:@"See where %@ is now", [[self dataParcel] driverName]]
			andBlock:^(BOOL expanded) {
				if ([self statusExpandDisable]) return;

				[self setStatusExpandDisable:YES];

				if (expanded) {
					[[self status] setHidden:YES];
				}

				[UIView
					animateWithDuration:[ABCOptionExpand Delay]
					animations:^{
						[[self statusExpand] setExpandState:!expanded];
						[[self status] setExpanded:!expanded];
						[self updateStatusBarHeightChangesWithDifference:0.0f];
					} completion:^(BOOL finished) {
						if (!expanded) {
							[[self status] setHidden:NO];
						}

						[self setStatusExpandDisable:NO];
					}];
			}]];
		[[self scrollView] addSubview:[self statusExpand]];

		[self setStatus:[[ABCDeliveryTodayStatus alloc] initWithDataParcel:[self dataParcel]]];
		[[self scrollView] addSubview:[self status]];
		[[self status] setHidden:YES];

		[self setMap:[[ABCDeliveryTodayMap alloc] init]];
		[[self scrollView] addSubview:[self map]];

		[self setMapKey:[[ABCDeliveryTodayMapKey alloc] init]];
		[[self scrollView] addSubview:[self mapKey]];

		[self setAlertLocation:[[ABCParcelDetailAlertLocation alloc] initWithArrowPosition:[[self mapKey] arrowPosition]]];
		[[self scrollView] addSubview:[self alertLocation]];

		[self setDropOffChoice:[[ABCDeliveryTodayDropOffChoice alloc] init]];
		[[self scrollView] addSubview:[self dropOffChoice]];

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

		top += [[self liveIssue]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self statusExpand]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		if ([[self status] expanded]) {
			top += [[self status]
				setPositionX:[AppDelegate SizePaddingFromSides]
				andPositionY:top];
		}

		top += [[self map]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [[self mapKey]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSidesThin];

		top += [[self alertLocation]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self dropOffChoice]
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
