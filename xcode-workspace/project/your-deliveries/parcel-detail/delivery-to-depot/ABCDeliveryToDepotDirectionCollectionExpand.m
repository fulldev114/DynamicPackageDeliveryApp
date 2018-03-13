//
//  ABCDeliveryToDepotDirectionCollectionExpand.m
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryToDepotDirectionCollectionExpand.h"

#import "ABCDataAddress.h"
#import "ABCDeliveryToDepotDirectionCollection.h"
#import "ABCOptionExpand.h"
#import "AppDelegate.h"

@interface ABCDeliveryToDepotDirectionCollectionExpand()
	@property (nonatomic, strong) BlockExpand blockExpand;
	@property (nonatomic) ABCDeliveryToDepotDirectionCollection* directionCollection;
	@property (nonatomic) ABCOptionExpand* directionCollectionExpand;
	@property (nonatomic) BOOL directionCollectionExpandDisable;
@end

@implementation ABCDeliveryToDepotDirectionCollectionExpand
	- (instancetype) initWithBlockExpand:(BlockExpand)blockExpand {
		self = [super init];

		if (!self) return nil;

		[self setBlockExpand:blockExpand];
		[self initialise];
		[self update];

		return self;
	}

	- (void) initialise {
		CGFloat top = 0.0f;

		[self setDirectionCollectionExpandDisable:NO];
		[self setDirectionCollectionExpand:[[ABCOptionExpand alloc]
			initWithText:NSLocalizedString(@"View Directions", nil)
			andBlock:^(BOOL expanded) {
				if ([self directionCollectionExpandDisable]) return;

				[self setDirectionCollectionExpandDisable:YES];

				if (expanded) {
					[[self directionCollection] setHidden:YES];
				}

				[UIView
					animateWithDuration:[ABCOptionExpand Delay]
					animations:^{
						[[self directionCollectionExpand] setExpandState:!expanded];
						[[self directionCollection] setExpanded:!expanded];
						CGFloat difference = [self update];
						[self blockExpand](difference);
					} completion:^(BOOL finished) {
						if (!expanded) {
							[[self directionCollection] setHidden:NO];
						}

						[self setDirectionCollectionExpandDisable:NO];
					}];
			}]];
		[self addSubview:[self directionCollectionExpand]];
		[[self directionCollectionExpand]
			setPositionX:0.0f
			andPositionY:top];
		top += [[self directionCollectionExpand] sizeView].height;

		[self setDirectionCollection:[[ABCDeliveryToDepotDirectionCollection alloc]
			initWithDataAddressUserCollection:@[
				[[ABCDataAddress alloc] initWithNSDictionary:@{
					@"address":@"16 Weston Drive, Tipton, West Midlands, DY4 OAE",
				}],
			]
			andDataAddressDepotCollection:@[
				[[ABCDataAddress alloc] initWithNSDictionary:@{
					@"address":@"Birmingham Road, Oldbury, West Midlands, B69 48F",
				}],
			]
			andDataDirectionCollection:@[
				[[ABCDataDirection alloc] initWithNSDictionary:@{
					@"directions":@"Head west on Weston Dr toward Kidd Croft",
					@"distance":@420,
				}],
				[[ABCDataDirection alloc] initWithNSDictionary:@{
					@"directions":@"Turn left onto Farmer Way",
					@"distance":@404,
				}],
			]]];
		[self addSubview:[self directionCollection]];
		[[self directionCollection] setHidden:YES];
		[[self directionCollection]
			setPositionX:0.0f
			andPositionY:top];
	}

	- (CGFloat) update {
		CGSize sizeView;
		sizeView.height = 0.0f;
		sizeView.width = [[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f);

		if ([[self directionCollection] expanded]) {
			sizeView.height += [[self directionCollection] sizeView].height;
		}

		CGFloat difference = sizeView.height;
		sizeView.height += [[self directionCollectionExpand] sizeView].height;
		[self setSizeView:sizeView];

		return difference;
	}
@end
