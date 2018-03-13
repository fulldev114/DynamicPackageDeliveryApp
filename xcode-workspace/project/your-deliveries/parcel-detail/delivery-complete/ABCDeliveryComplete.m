//
//  ABCDeliveryComplete.m
//  your-dpd
//
//  Created by Richard Simkins on 21/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryComplete.h"

#import "ABCDeliveryCompleteGallery.h"
#import "ABCDeliveryCompleteImage.h"
#import "ABCDeliveryCompleteMap.h"
#import "ABCDeliveryCompleteParcel.h"
#import "ABCParcelDetailLocationCollectionExpand.h"
#import "AppDelegate.h"
#import "UIScrollView+ABC.h"

@interface ABCDeliveryComplete()
	@property (nonatomic) ABCDataParcel* dataParcel;
	@property (nonatomic) ABCDeliveryCompleteGallery* gallery;
	@property (nonatomic) ABCParcelDetailLocationCollectionExpand* locationCollectionExpand;
	@property (nonatomic) ABCDeliveryCompleteMap* map;
	@property (nonatomic) UILabel* mapLabel;
	@property (nonatomic) CGSize mapLabelSize;
	@property (nonatomic) ABCDeliveryCompleteParcel* parcel;
	@property (nonatomic) UIScrollView* scrollView;
@end

@implementation ABCDeliveryComplete
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

		[self setParcel:[[ABCDeliveryCompleteParcel alloc] initWithDataParcel:[self dataParcel]]];
		[[self scrollView] addSubview:[self parcel]];

		[self setGallery:[[ABCDeliveryCompleteGallery alloc] initWithBlockItemTapped:^(NSInteger tag) {
			// o It dismisses itself.
			ABCDeliveryCompleteImage* image = [[ABCDeliveryCompleteImage alloc] initWithParentHeight:[[self view] frame].size.height];
			AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
			[[appDelegate window] addSubview:image];
		}]];
		[[self scrollView] addSubview:[self gallery]];

		[self setMapLabel:[[UILabel alloc] init]];
		[[self scrollView] addSubview:[self mapLabel]];
		[[self mapLabel] setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[[self mapLabel] setNumberOfLines:1];
		[[self mapLabel] setText:NSLocalizedString(@"Delivery location on map", nil)];
		[[self mapLabel] setTextColor:[AppDelegate ColourAppBlack]];

		[self setMapLabelSize:[[self mapLabel] sizeThatFits:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			[[UIScreen mainScreen] bounds].size.height)]];

		[self setMap:[[ABCDeliveryCompleteMap alloc] init]];
		[[self scrollView] addSubview:[self map]];

		[self setLocationCollectionExpand:[[ABCParcelDetailLocationCollectionExpand alloc] initWithBlockExpand:^(CGFloat difference) {
			[self updateStatusBarHeightChangesWithDifference:0.0f];
			[[self scrollView] setContentOffsetDifference:difference];
		}]];
		[[self scrollView] addSubview:[self locationCollectionExpand]];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		top += [[self parcel]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self gallery]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSidesThin];

		[[self mapLabel] setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSides],
			top,
			[self mapLabelSize].width,
			[self mapLabelSize].height)];
		top += [self mapLabelSize].height;

		top += [AppDelegate SizePaddingFromSidesThin];

		top += [[self map]
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
