//
//  ABCCollectShopLoadMore.m
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCCollectShopLoadMore.h"

#import "AppDelegate.h"

@interface ABCCollectShopLoadMore()
	@property (nonatomic, strong) BlockLoadMore blockLoadMore;
	@property (nonatomic) NSString* text;
@end

@implementation ABCCollectShopLoadMore
	- (instancetype)
		initWithText:(NSString*)text
		andBlockLoadMore:(BlockLoadMore)blockLoadMore {

		self = [super init];

		if (!self) return nil;

		[self setBlockLoadMore:blockLoadMore];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			47.0f)];
		[self setText:text];

		[self setBackgroundColor:[AppDelegate ColourAppGreyDark]];
		[self
			addTarget:self
			action:@selector(tap)
			forControlEvents:UIControlEventTouchUpInside];
		[self
			setTitle:text
			forState:UIControlStateNormal];
		[self
			setTitleColor:[UIColor whiteColor]
			forState:UIControlStateNormal];
		[[self titleLabel] setFont:[AppDelegate FontRegularWithSize:16.0f]];

		return self;
	}

	- (void) tap {
		[self blockLoadMore]();
	}
@end
