//
//  ABCParcelDetailOptionCollectionExpand.m
//  your-dpd
//
//  Created by Richard Simkins on 20/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCParcelDetailOptionCollectionExpand.h"

#import "ABCCollectDepot.h"
#import "ABCCollectShop.h"
#import "ABCDeliverDate.h"
#import "ABCDeliverNeighbour.h"
#import "ABCDeliverSafePlace.h"
#import "ABCOptionDrillDown.h"
#import "ABCOptionExpand.h"
#import "ABCUpgradeDelivery.h"
#import "AppDelegate.h"

@interface ABCParcelDetailOptionCollectionExpand()
	@property (nonatomic, strong) BlockExpand blockExpand;
	@property (nonatomic) ABCDataParcel* dataParcel;
	@property (nonatomic) UINavigationController* navigationController;
	@property (nonatomic) ABCOptionExpand* optionCollectionExpand;
	@property (nonatomic) BOOL optionCollectionExpandDisable;
	@property (nonatomic) ABCOptionDrillDown* optionDate;
	@property (nonatomic) ABCOptionDrillDown* optionDepot;
	@property (nonatomic) ABCOptionDrillDown* optionNeighbour;
	@property (nonatomic) ABCOptionDrillDown* optionSafePlace;
	@property (nonatomic) ABCOptionDrillDown* optionShop;
	@property (nonatomic) ABCOptionDrillDown* optionUpgrade;
@end

@implementation ABCParcelDetailOptionCollectionExpand
	- (instancetype)
		initWithNavigationController:(UINavigationController*)navigationController
		andDataParcel:(ABCDataParcel*)dataParcel
		andBlockExpand:(BlockExpand)blockExpand {

		self = [super init];

		if (!self) return nil;

		[self setBlockExpand:blockExpand];
		[self setDataParcel:dataParcel];
		[self setNavigationController:navigationController];
		[self initialise];
		[self update];

		return self;
	}

	- (void) initialise {
		CGFloat top = 0.0f;

		[self setOptionCollectionExpandDisable:NO];
		[self setOptionCollectionExpand:[[ABCOptionExpand alloc]
			initWithText:NSLocalizedString(@"Your options", nil)
			andBlock:^(BOOL expanded) {
				if ([self optionCollectionExpandDisable]) return;

				[self setOptionCollectionExpandDisable:YES];

				if (expanded) {
					[[self optionDate] setHidden:YES];
					[[self optionDepot] setHidden:YES];
					[[self optionNeighbour] setHidden:YES];
					[[self optionSafePlace] setHidden:YES];
					[[self optionShop] setHidden:YES];
					[[self optionUpgrade] setHidden:YES];
				}

				[UIView
					animateWithDuration:[ABCOptionExpand Delay]
					animations:^{
						[[self optionCollectionExpand] setExpandState:!expanded];
						[[self optionDate] setExpanded:!expanded];
						[[self optionDepot] setExpanded:!expanded];
						[[self optionNeighbour] setExpanded:!expanded];
						[[self optionSafePlace] setExpanded:!expanded];
						[[self optionShop] setExpanded:!expanded];
						[[self optionUpgrade] setExpanded:!expanded];
						CGFloat difference = [self update];
						[self blockExpand](difference);
					} completion:^(BOOL finished) {
						if (!expanded) {
							[[self optionDate] setHidden:NO];
							[[self optionDepot] setHidden:NO];
							[[self optionNeighbour] setHidden:NO];
							[[self optionSafePlace] setHidden:NO];
							[[self optionShop] setHidden:NO];
							[[self optionUpgrade] setHidden:NO];
						}

						[self setOptionCollectionExpandDisable:NO];
					}];
			}]];
		[self addSubview:[self optionCollectionExpand]];
		[[self optionCollectionExpand]
			setPositionX:0.0f
			andPositionY:top];
		top += [[self optionCollectionExpand] sizeView].height;

		[self setOptionShop:[[ABCOptionDrillDown alloc]
			initWithText:NSLocalizedString(@"Collect from Pickup shop", nil)
			andBlock:^{
				ABCCollectShop* viewController = [[ABCCollectShop alloc] initWithDataParcel:[self dataParcel]];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];

		[self setOptionDepot:[[ABCOptionDrillDown alloc]
			initWithText:NSLocalizedString(@"Collect from DPD depot", nil)
			andBlock:^{
				ABCCollectDepot* viewController = [[ABCCollectDepot alloc] initWithDataParcel:[self dataParcel]];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];

		[self setOptionSafePlace:[[ABCOptionDrillDown alloc]
			initWithText:NSLocalizedString(@"Deliver to safe place", nil)
			andBlock:^{
				ABCDeliverSafePlace* viewController = [[ABCDeliverSafePlace alloc] initWithDataParcel:[self dataParcel]];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];

		[self setOptionNeighbour:[[ABCOptionDrillDown alloc]
			initWithText:NSLocalizedString(@"Deliver to neighbour", nil)
			andBlock:^{
				ABCDeliverNeighbour* viewController = [[ABCDeliverNeighbour alloc] initWithDataParcel:[self dataParcel]];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];

		[self setOptionDate:[[ABCOptionDrillDown alloc]
			initWithText:NSLocalizedString(@"Change the delivery date", nil)
			andBlock:^{
				ABCDeliverDate* viewController = [[ABCDeliverDate alloc] initWithDataParcel:[self dataParcel]];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];

		[self setOptionUpgrade:[[ABCOptionDrillDown alloc]
			initWithText:NSLocalizedString(@"Upgrade delivery", nil)
			andBlock:^{
				ABCUpgradeDelivery* viewController = [[ABCUpgradeDelivery alloc] init];
				[[self navigationController]
					pushViewController:viewController
					animated:YES];
			}]];

		for (ABCOptionDrillDown* option in @[
			[self optionShop],
			[self optionDepot],
			[self optionSafePlace],
			[self optionNeighbour],
			[self optionDate],
			[self optionUpgrade],
		]) {
			[self addSubview:option];
			[option setHidden:YES];
			top = [option positionWithTop:top];
		}
	}

	- (CGFloat) update {
		CGSize sizeView;
		sizeView.height = 0.0f;
		sizeView.width = [[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f);

		for (ABCOptionDrillDown* option in @[
			[self optionShop],
			[self optionDepot],
			[self optionSafePlace],
			[self optionNeighbour],
			[self optionDate],
			[self optionUpgrade],
		]) {
			if (![option expanded]) continue;

			sizeView.height += [option sizeView].height;
		}

		CGFloat difference = sizeView.height;
		sizeView.height += [[self optionCollectionExpand] sizeView].height;
		[self setSizeView:sizeView];

		return difference;
	}
@end
