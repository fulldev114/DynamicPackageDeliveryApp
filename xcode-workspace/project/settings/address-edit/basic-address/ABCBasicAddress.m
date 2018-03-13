//
//  ABCBasicAddress.m
//  your-dpd
//
//  Created by Richard Simkins on 12/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCBasicAddress.h"

#import "ABCBasicAddressNote.h"
#import "ABCBasicAddressSpecifyOther.h"
#import "ABCBasicAddressTitle.h"
#import "ABCBasicAddressTypeCollection.h"
#import "ABCDataAddress.h"
#import "ABCScrollView.h"
#import "AppDelegate.h"

@interface ABCBasicAddress()
	@property (nonatomic) ABCBasicAddressNote* note;
	@property (nonatomic) ABCScrollView* scrollView;
	@property (nonatomic) ABCBasicAddressSpecifyOther* specifyOther;
	@property (nonatomic) ABCBasicAddressTitle* titleView;
	@property (nonatomic) ABCBasicAddressTypeCollection* typeCollection;
@end

@implementation ABCBasicAddress
	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setTitle:NSLocalizedString(@"Manage Address", nil)];

		return self;
	}

	- (void) viewDidLoad {
		[super viewDidLoad];

		[self setScrollView:[[ABCScrollView alloc] initWithBlockKeyboardStateChange:^{
			[self updateStatusBarHeightChangesWithDifference:0.0f];
		}]];
		[[self view] addSubview:[self scrollView]];

		[self setTitleView:[[ABCBasicAddressTitle alloc] init]];
		[[self scrollView] backgroundAddSubView:[self titleView]];

		[self setTypeCollection:[[ABCBasicAddressTypeCollection alloc]
			initWithDataCollection:@[
				@"Home",
				@"Work",
				@"Other",
			]
			andBlockOther:^() {
				if (![[self typeCollection] otherSelected]) {
					[[self specifyOther] empty];
				}

				[[self scrollView] tapKeyboardDismiss];
				[self updateStatusBarHeightChangesWithDifference:0.0f];
			}]];
		[[self scrollView] foregroundAddSubViewCollection:[[self typeCollection] viewCollectionForScrollViewForeground]];

		[self setSpecifyOther:[[ABCBasicAddressSpecifyOther alloc] init]];
		[[self scrollView] backgroundAddSubView:[self specifyOther]];
		[[self scrollView] foregroundAddSubViewCollection:[[self specifyOther] viewCollectionForScrollViewForeground]];

		[self setNote:[[ABCBasicAddressNote alloc] init]];
		[[self scrollView] backgroundAddSubView:[self note]];
		[[self scrollView] foregroundAddSubViewCollection:[[self note] viewCollectionForScrollViewForeground]];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		top += [[self titleView]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSidesThin];

		top += [[self typeCollection]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		[[self specifyOther] setHidden:![[self typeCollection] otherSelected]];

		if ([[self typeCollection] otherSelected]) {
			top += [AppDelegate SizePaddingFromSides];

			top += [[self specifyOther]
				setPositionX:[AppDelegate SizePaddingFromSides]
				andPositionY:top];
		}

		top += [AppDelegate SizePaddingFromSides];

		top += [[self note]
			setPositionX:[AppDelegate SizePaddingFromSides]
			andPositionY:top];

		top += [AppDelegate SizePaddingFromSides];

		[[self scrollView]
			setFrameHeight:[[self view] frame].size.height + difference
			andContentHeight:top];
	}
@end
