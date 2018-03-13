//
//  ABCYourDeliveriesSection.m
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourDeliveriesSection.h"

#import "AppDelegate.h"

@interface ABCYourDeliveriesSection()
	@property (nonatomic) NSInteger count;
	@property (nonatomic) NSInteger index;
@end

@implementation ABCYourDeliveriesSection
	- (CGFloat) SizeSeparationWidth {
		return 8.0f;
	}

	+ (NSInteger) Total {
		return 2;
	}

	- (instancetype)
		initWithIndex:(NSInteger)index
		andCount:(NSInteger)count
		andSizeView:(CGSize)sizeView {

		self = [super init];

		if (!self) return nil;

		[self setCount:count];
		[self setIndex:index];
		[self setSizeView:sizeView];
		[self initialise];

		return self;
	}

	- (void) initialise {
		UILabel* title = [[UILabel alloc] init];
		[self addSubview:title];
		[title setFont:[AppDelegate FontRegularWithSize:16.0f]];
		[title setNumberOfLines:1];

		if ([self index] == 0) {
			[title setText:NSLocalizedString(@"Active Deliveries", nil)];
		} else {
			[title setText:NSLocalizedString(@"Previous Deliveries", nil)];
		}

		[title setTextColor:[AppDelegate ColourAppRed]];
		CGSize titleSize = [title sizeThatFits:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width,
			[self sizeView].height)];
		[title setFrame:CGRectMake(
			0.0f,
			([self sizeView].height - titleSize.height) / 2.0f,
			titleSize.width,
			titleSize.height)];

		UILabel* count = [[UILabel alloc] init];
		[self addSubview:count];
		[count setFont:[AppDelegate FontRegularWithSize:16.0f]];
		[count setNumberOfLines:1];
		[count setText:[NSString stringWithFormat:@"(%ld)", (long)[self count]]];
		[count setTextColor:[AppDelegate ColourAppGreyDark]];
		CGSize countSize = [count sizeThatFits:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width,
			[self sizeView].height)];
		[count setFrame:CGRectMake(
			titleSize.width + [self SizeSeparationWidth],
			([self sizeView].height - countSize.height) / 2.0f,
			countSize.width,
			countSize.height)];
	}
@end
