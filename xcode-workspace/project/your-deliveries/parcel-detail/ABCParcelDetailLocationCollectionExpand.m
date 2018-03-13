//
//  ABCParcelDetailLocationCollectionExpand.m
//  your-dpd
//
//  Created by Richard Simkins on 20/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCParcelDetailLocationCollectionExpand.h"

#import "ABCOptionExpand.h"
#import "ABCParcelDetailLocationCollection.h"
#import "AppDelegate.h"

@interface ABCParcelDetailLocationCollectionExpand()
	@property (nonatomic, strong) BlockExpand blockExpand;
	@property (nonatomic) NSArray* dataParcelLocationCollection;
	@property (nonatomic) ABCParcelDetailLocationCollection* locationCollection;
	@property (nonatomic) ABCOptionExpand* locationCollectionExpand;
	@property (nonatomic) BOOL locationCollectionExpandDisable;
@end

@implementation ABCParcelDetailLocationCollectionExpand
	- (instancetype) initWithBlockExpand:(BlockExpand)blockExpand {

		self = [super init];

		if (!self) return nil;

		[self setBlockExpand:blockExpand];
		[self setDataParcelLocationCollection:@[
			[[ABCDataParcelLocation alloc] initWithNSDictionary:@{
				@"date":@"12 Apr 2015 12:32",
				@"event_description":@"We are 30 minutes away from your delivery address.",
				@"place_name":@"Manchester",
			}],
			[[ABCDataParcelLocation alloc] initWithNSDictionary:@{
				@"date":@"12 Apr 2015 09:54",
				@"event_description":@"Your parcel will be with you today.",
				@"place_name":@"Manchester",
			}],
			[[ABCDataParcelLocation alloc] initWithNSDictionary:@{
				@"date":@"11 Apr 2015 07:02",
				@"event_description":@"Your parcel is with your nearest delivery depot in Reading.",
				@"place_name":@"Manchester",
			}],
			[[ABCDataParcelLocation alloc] initWithNSDictionary:@{
				@"date":@"10 Apr 2015 16:35",
				@"event_description":@"We have your parcel and it's on its way to your nearest depot in Reading.",
				@"place_name":@"Hub 3 - Birmingham",
			}],
		]];
		[self initialise];
		[self update];

		return self;
	}

	- (void) initialise {
		CGFloat top = 0.0f;

		[self setLocationCollectionExpandDisable:NO];
		[self setLocationCollectionExpand:[[ABCOptionExpand alloc]
			initWithText:NSLocalizedString(@"Where has my parcel been?", nil)
			andBlock:^(BOOL expanded) {
				if ([self locationCollectionExpandDisable]) return;

				[self setLocationCollectionExpandDisable:YES];

				if (expanded) {
					[[self locationCollection] setHidden:YES];
				}

				[UIView
					animateWithDuration:[ABCOptionExpand Delay]
					animations:^{
						[[self locationCollectionExpand] setExpandState:!expanded];
						[[self locationCollection] setExpanded:!expanded];
						CGFloat difference = [self update];
						[self blockExpand](difference);
					} completion:^(BOOL finished) {
						if (!expanded) {
							[[self locationCollection] setHidden:NO];
						}

						[self setLocationCollectionExpandDisable:NO];
					}];
			}]];
		[self addSubview:[self locationCollectionExpand]];
		[[self locationCollectionExpand]
			setPositionX:0.0f
			andPositionY:top];
		top += [[self locationCollectionExpand] sizeView].height;

		[self setLocationCollection:[[ABCParcelDetailLocationCollection alloc] initWithDataParcelLocationCollection:[self dataParcelLocationCollection]]];
		[self addSubview:[self locationCollection]];
		[[self locationCollection] setHidden:YES];
		[[self locationCollection]
			setPositionX:0.0f
			andPositionY:top];
	}

	- (CGFloat) update {
		CGSize sizeView;
		sizeView.height = 0.0f;
		sizeView.width = [[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f);

		if ([[self locationCollection] expanded]) {
			sizeView.height += [[self locationCollection] sizeView].height;
		}

		CGFloat difference = sizeView.height;
		sizeView.height += [[self locationCollectionExpand] sizeView].height;
		[self setSizeView:sizeView];

		return difference;
	}
@end
