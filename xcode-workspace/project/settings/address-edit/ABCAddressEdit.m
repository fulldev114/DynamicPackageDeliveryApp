//
//  ABCAddressEdit.m
//  your-dpd
//
//  Created by Richard Simkins on 05/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCAddressEdit.h"

#import "ABCAddressEditDanger.h"
#import "ABCAddressEditDrillDown.h"
#import "ABCAddressEditSection.h"
#import "ABCAddressEditTitle.h"
#import "ABCBasicAddress.h"
#import "ABCFirstAttempt.h"
#import "ABCNeighbour.h"
#import "ABCPickUpShop.h"
#import "ABCSafePlace.h"
#import "AppDelegate.h"

@interface ABCAddressEdit()
	@property (nonatomic) ABCAddressEditDrillDown* basicAddress;
	@property (nonatomic) ABCAddressEditDanger* danger;
	@property (nonatomic) ABCAddressEditDrillDown* firstAttempt;
	@property (nonatomic) ABCAddressEditDrillDown* neighbour;
	@property (nonatomic) ABCAddressEditDrillDown* pickUp;
	@property (nonatomic) ABCAddressEditDrillDown* safePlace;
	@property (nonatomic) ABCAddressEditSection* section;
	@property (nonatomic) ABCAddressEditTitle* titleView;
	@property (nonatomic) UIScrollView* scrollView;
@end

@implementation ABCAddressEdit
	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setTitle:NSLocalizedString(@"Manage Address", nil)];

		return self;
	}

	- (void) viewDidLoad {
		[super viewDidLoad];

		[self setScrollView:[[UIScrollView alloc] init]];
		[[self view] addSubview:[self scrollView]];

		[self setTitleView:[[ABCAddressEditTitle alloc] init]];
		[[self scrollView] addSubview:[self titleView]];

		[self setBasicAddress:[[ABCAddressEditDrillDown alloc]
			initWithText:NSLocalizedString(@"Edit basic address info", nil)
			andBlock:^{
				ABCBasicAddress* viewController = [[ABCBasicAddress alloc] init];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];
		[[self scrollView] addSubview:[self basicAddress]];

		[self setSafePlace:[[ABCAddressEditDrillDown alloc]
			initWithText:NSLocalizedString(@"Edit safe place details", nil)
			andBlock:^{
				ABCSafePlace* viewController = [[ABCSafePlace alloc] init];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];
		[[self scrollView] addSubview:[self safePlace]];

		[self setNeighbour:[[ABCAddressEditDrillDown alloc]
			initWithText:NSLocalizedString(@"Edit neighbour delivery preferences", nil)
			andBlock:^{
				ABCNeighbour* viewController = [[ABCNeighbour alloc] init];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];
		[[self scrollView] addSubview:[self neighbour]];

		[self setPickUp:[[ABCAddressEditDrillDown alloc]
			initWithText:NSLocalizedString(@"Edit Pickup Shop delivery preferences", nil)
			andBlock:^{
				ABCPickUpShop* viewController = [[ABCPickUpShop alloc] init];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];
		[[self scrollView] addSubview:[self pickUp]];

		[self setFirstAttempt:[[ABCAddressEditDrillDown alloc]
			initWithText:NSLocalizedString(@"Edit first attempt preferences", nil)
			andBlock:^{
				ABCFirstAttempt* viewController = [[ABCFirstAttempt alloc] init];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];
		[[self scrollView] addSubview:[self firstAttempt]];

		[self setSection:[[ABCAddressEditSection alloc] initWithTitle:NSLocalizedString(@"Danger Zone!", nil)]];
		[[self scrollView] addSubview:[self section]];

		[self setDanger:[[ABCAddressEditDanger alloc] initWithBlock:^{
			[self
				confirmWithTitle:NSLocalizedString(@"Are you sure you want to delete this address?", nil)
				andMessage:NSLocalizedString(@"Select 'DELETE' to permanently delete this address and its preferences?", nil)
				andCancel:@"Cancel"
				andDestructive:@"Delete"
				andBlockConfirm:^{
				}];
		}]];
		[[self scrollView] addSubview:[self danger]];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		top += [[self titleView]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		top += [[self basicAddress]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [[self safePlace]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [[self neighbour]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [[self pickUp]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [[self firstAttempt]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [ABCAddressEditSection SizeMarginTop];

		top += [[self section]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [[self danger]
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
