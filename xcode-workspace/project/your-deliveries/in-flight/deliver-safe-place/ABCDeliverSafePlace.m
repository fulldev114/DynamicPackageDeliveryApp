//
//  ABCDeliverSafePlace.m
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliverSafePlace.h"

#import "ABCAccept.h"
#import "ABCConfirm.h"
#import "ABCDeliverSafePlaceAlertAccept.h"
#import "ABCDeliverSafePlaceInstruction.h"
#import "ABCDeliverSafePlaceParcel.h"
#import "ABCDeliverSafePlacePhoto.h"
#import "ABCDeliverSafePlaceSelectCollection.h"
#import "AppDelegate.h"

@interface ABCDeliverSafePlace()
	@property (nonatomic) ABCAccept* accept;
	@property (nonatomic) ABCDeliverSafePlaceAlertAccept* alertAccept;
	@property (nonatomic) ABCConfirm* confirm;
	@property (nonatomic) ABCDataParcel* dataParcel;
	@property (nonatomic) ABCDeliverSafePlaceInstruction* instruction;
	@property (nonatomic) UIButton* keyboardDismiss;
	@property (nonatomic) CGSize keyboardSize;
	@property (nonatomic) ABCDeliverSafePlaceParcel* parcel;
	@property (nonatomic) ABCDeliverSafePlacePhoto* photo;
	@property (nonatomic) UIScrollView* scrollView;
	@property (nonatomic) ABCDeliverSafePlaceSelectCollection* selectCollection;
@end

@implementation ABCDeliverSafePlace
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

	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel {
		self = [super init];

		if (!self) return nil;

		[self setDataParcel:dataParcel];
		[self setKeyboardSize:CGSizeZero];

		[self setTitle:NSLocalizedString(@"Leave in Safe Place", nil)];

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
			initWithText:NSLocalizedString(@"Confirm Changes", nil)
			andBlock:^{
				[self
					confirmWithTitle:NSLocalizedString(@"Are you sure you want to change this delivery?", nil)
					andMessage:NSLocalizedString(@"Select 'Yes' to confirm and deliver directly to your 'Safe Place'?", nil)
					andBlockConfirm:^{
						[[self navigationController] popViewControllerAnimated:YES];
					}];
			}]];
		[[self view] addSubview:[self confirm]];

		[self setKeyboardDismiss:[UIButton buttonWithType:UIButtonTypeCustom]];
		[[self scrollView] addSubview:[self keyboardDismiss]];
		[[self keyboardDismiss]
			addTarget:self
			action:@selector(tapKeyboardDismiss)
			forControlEvents:UIControlEventTouchUpInside];
		[[self keyboardDismiss] setHidden:YES];

		[self setParcel:[[ABCDeliverSafePlaceParcel alloc] initWithDataParcel:[self dataParcel]]];
		[[self scrollView] addSubview:[self parcel]];

		[self setSelectCollection:[[ABCDeliverSafePlaceSelectCollection alloc] initWithSelectCollection:@[
			NSLocalizedString(@"Front Porch", nil),
			NSLocalizedString(@"Rear Porch", nil),
			NSLocalizedString(@"Garage", nil),
			NSLocalizedString(@"Shed", nil),
			NSLocalizedString(@"Other", nil),
		]]];
		[[self scrollView] addSubview:[self selectCollection]];

		[self setPhoto:[[ABCDeliverSafePlacePhoto alloc] init]];
		[[self scrollView] addSubview:[self photo]];

		[self setInstruction:[[ABCDeliverSafePlaceInstruction alloc] init]];
		[[self scrollView] addSubview:[self instruction]];
		[[self instruction] textViewAddToScrollView:[self scrollView]];

		[self setAccept:[[ABCAccept alloc]
			initWithTitle:NSLocalizedString(@"I accept full responsibility for parcels that are left in a safe place.", nil)
			andBlockAccept:^{
			}]];
		[[self scrollView] addSubview:[self accept]];

		[self setAlertAccept:[[ABCDeliverSafePlaceAlertAccept alloc] init]];
		[[self scrollView] addSubview:[self alertAccept]];
	}

	- (void) keyboardWillHide:(NSNotification*)notification {
		[[self scrollView] setContentOffset:CGPointMake(
			[[self scrollView] contentOffset].x,
			[[self scrollView] contentOffset].y - [self keyboardSize].height)];
		[[self scrollView] setScrollEnabled:YES];
		[self setKeyboardSize:CGSizeZero];
		[self updateStatusBarHeightChangesWithDifference:0.0f];
	}

	- (void) keyboardWillShow:(NSNotification*)notification {
		[self setKeyboardSize:[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size];
		[self updateStatusBarHeightChangesWithDifference:0.0f];
		[[self keyboardDismiss] setHidden:NO];
		[[self scrollView] bringSubviewToFront:[self keyboardDismiss]];
		[[self scrollView] setContentOffset:CGPointMake(
			[[self scrollView] contentOffset].x,
			[[self instruction] frame].origin.y)];
		[[self instruction] bringToTopOfScrollView:[self scrollView]];
		[[self scrollView] setScrollEnabled:NO];
	}

	- (void) tapKeyboardDismiss {
		[[self keyboardDismiss] setHidden:YES];
		[[self instruction] resign];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		top += [[self parcel]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self selectCollection]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self photo]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self instruction]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides] * 2.0f;

		top += [[self accept]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self alertAccept]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

/*		[[self scrollView] setContentOffset:CGPointMake(
			[[self scrollView] contentOffset].x,
			[[self scrollView] contentOffset].y + [self keyboardSize].height)];*/
		[[self scrollView] setContentSize:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width,
			top)];
		[[self scrollView] setFrame:CGRectMake(
			0.0f,
			0.0f,
			[[UIScreen mainScreen] bounds].size.width,
			[[self view] frame].size.height - [[self confirm] SizeViewHeight] - [self keyboardSize].height + difference)];

		[[self confirm] setFrame:CGRectMake(
			0.0f,
			[[self view] frame].size.height - [[self confirm] SizeViewHeight] - [self keyboardSize].height + difference,
			[[self confirm] SizeViewWidth],
			[[self confirm] SizeViewHeight])];

		[[self keyboardDismiss] setFrame:CGRectMake(
			0.0f,
			0.0f,
			[[UIScreen mainScreen] bounds].size.width,
			[[self scrollView] contentSize].height)];
	}
@end
