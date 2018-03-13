//
//  ABCUpgradeDelivery.m
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCUpgradeDelivery.h"

#import "ABCConfirm.h"
#import "ABCDataDate.h"
#import "ABCDataTimeslot.h"
#import "ABCUpgradeDeliveryAddress.h"
#import "ABCUpgradeDeliveryDateCollection.h"
#import "ABCUpgradeDeliveryPayment.h"
#import "ABCUpgradeDeliveryTimeslotCollection.h"
#import "AppDelegate.h"

@interface ABCUpgradeDelivery()
	@property (nonatomic) ABCUpgradeDeliveryAddress* address;
	@property (nonatomic) ABCConfirm* confirm;
	@property (nonatomic) ABCUpgradeDeliveryDateCollection* dateCollection;
	@property (nonatomic) UIButton* keyboardDismiss;
	@property (nonatomic) CGSize keyboardSize;
	@property (nonatomic) ABCUpgradeDeliveryPayment* payment;
	@property (nonatomic) UIScrollView* scrollView;
	@property (nonatomic) ABCUpgradeDeliveryTimeslotCollection* timeslotCollection;
@end

@implementation ABCUpgradeDelivery
	- (void) dealloc {
		[[NSNotificationCenter defaultCenter]
			removeObserver:self
			name:UIKeyboardWillHideNotification
			object:nil];
		[[NSNotificationCenter defaultCenter]
			removeObserver:self
			name:UIKeyboardWillShowNotification
			object:nil];
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setTitle:NSLocalizedString(@"Upgrade Delivery", nil)];

		[[NSNotificationCenter defaultCenter]
			addObserver:self
			selector:@selector(keyboardWillShow:)
			name:UIKeyboardWillShowNotification object:nil];
		[[NSNotificationCenter defaultCenter]
			addObserver:self
			selector:@selector(keyboardWillHide:)
			name:UIKeyboardWillHideNotification object:nil];

		return self;
	}

	- (void) viewDidLoad {
		[super viewDidLoad];

		[self setScrollView:[[UIScrollView alloc] init]];
		[[self view] addSubview:[self scrollView]];

		[self setConfirm:[[ABCConfirm alloc]
			initWithText:NSLocalizedString(@"Pay Now", nil)
			andBlock:^{
				[[self navigationController] popViewControllerAnimated:YES];
			}]];
		[[self scrollView] addSubview:[self confirm]];

		[self setKeyboardDismiss:[UIButton buttonWithType:UIButtonTypeCustom]];
		[[self scrollView] addSubview:[self keyboardDismiss]];
		[[self keyboardDismiss]
			addTarget:self
			action:@selector(tapKeyboardDismiss)
			forControlEvents:UIControlEventTouchUpInside];
		[[self keyboardDismiss] setHidden:YES];

		[self setAddress:[[ABCUpgradeDeliveryAddress alloc] init]];
		[[self scrollView] addSubview:[self address]];
		[[self address] textViewAddToScrollView:[self scrollView]];

		[self setDateCollection:[[ABCUpgradeDeliveryDateCollection alloc] initWithDataDateCollection:@[
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

		[self setTimeslotCollection:[[ABCUpgradeDeliveryTimeslotCollection alloc] initWithDataTimeslotCollection:@[
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

		[self setPayment:[[ABCUpgradeDeliveryPayment alloc] init]];
		[[self scrollView] addSubview:[self payment]];
	}

	- (void) keyboardWillHide:(NSNotification*)notification {
		[[self scrollView] setScrollEnabled:YES];
		[self setKeyboardSize:CGSizeZero];
		[self updateStatusBarHeightChangesWithDifference:0.0f];
	}

	- (void) keyboardWillShow:(NSNotification*)notification {
		[self setKeyboardSize:[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size];
		[self updateStatusBarHeightChangesWithDifference:0.0f];
		[[self keyboardDismiss] setHidden:NO];
		[[self scrollView] bringSubviewToFront:[self keyboardDismiss]];
		[[self address] bringToTopOfScrollView:[self scrollView]];
		[[self scrollView] setContentOffset:CGPointMake(
			[[self scrollView] contentOffset].x,
			0.0f)];
		[[self scrollView] setScrollEnabled:NO];
	}

	- (void) tapKeyboardDismiss {
		[[self keyboardDismiss] setHidden:YES];
		[[self address] resign];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		top += [[self address]
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

		top += [[self payment]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		[[self confirm] setFrame:CGRectMake(
			0.0f,
			top,
			[[self confirm] SizeViewWidth],
			[[self confirm] SizeViewHeight])];

		top += [[self confirm] SizeViewHeight];

		[[self scrollView] setContentSize:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width,
			top)];

		[[self scrollView] setFrame:CGRectMake(
			0.0f,
			0.0f,
			[[UIScreen mainScreen] bounds].size.width,
			[[self view] frame].size.height - [self keyboardSize].height + difference)];

		[[self keyboardDismiss] setFrame:CGRectMake(
			0.0f,
			0.0f,
			[[UIScreen mainScreen] bounds].size.width,
			[[self scrollView] contentSize].height)];
	}
@end
