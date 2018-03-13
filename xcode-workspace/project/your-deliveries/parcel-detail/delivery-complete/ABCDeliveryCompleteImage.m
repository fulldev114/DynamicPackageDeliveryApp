//
//  ABCDeliveryCompleteImage.m
//  your-dpd
//
//  Created by Richard Simkins on 22/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryCompleteImage.h"

#import "AppDelegate.h"

@interface ABCDeliveryCompleteImage()
	@property (nonatomic) CGFloat parentHeight;
@end

@implementation ABCDeliveryCompleteImage
	- (CGFloat) SizeImageHeight {
		return 290.0f;
	}

	- (CGFloat) SizeViewHeight {
		return 360.0f;
	}

	- (instancetype) initWithParentHeight:(CGFloat)parentHeight {
		self = [super initWithFrame:CGRectMake(
			0.0f,
			0.0f,
			[[UIScreen mainScreen] bounds].size.width,
			[[UIScreen mainScreen] bounds].size.height)];

		if (!self) return nil;

		[self setParentHeight:parentHeight];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setBackgroundColor:[UIColor
			colorWithRed:2.0f/3.0f
			green:2.0f/3.0f
			blue:2.0f/3.0f
			alpha:1.0f/3.0f]];

		// # The navigation bar height can change. For instance, when in a call.
		CGFloat navigationBarHeight = [[UIScreen mainScreen] bounds].size.height - [self parentHeight];

		UIView* view = [[UIView alloc] init];
		[self addSubview:view];
		[view setBackgroundColor:[UIColor whiteColor]];
		[view setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSides],
			navigationBarHeight + [AppDelegate SizePaddingFromSides],
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			[self SizeViewHeight])];

		UIView* image = [[UIView alloc] init];
		[view addSubview:image];
		[image setBackgroundColor:[UIColor yellowColor]];
		[image setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSides],
			[AppDelegate SizePaddingFromSides],
			[view frame].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			[self SizeImageHeight])];

		UILabel* label = [[UILabel alloc] init];
		[view addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:1];
		[label setText:NSLocalizedString(@"Delivered to Safe Place", nil)];
		[label setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[view frame].size.width,
			[view frame].size.height)];

		[label setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSides],
			[image frame].origin.y + [image frame].size.height + [AppDelegate SizePaddingFromSides],
			labelSize.width,
			labelSize.height)];

		UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
		[view addSubview:button];
		[button
			addTarget:self
			action:@selector(tap)
			forControlEvents:UIControlEventTouchUpInside];
		[button setImage:[UIImage imageNamed:@"delivery-complete-image-dismiss.png"] forState:UIControlStateNormal];
		[button setFrame:CGRectMake(
			[view frame].size.width - [AppDelegate SizeIcon40],
			0.0f,
			[AppDelegate SizeIcon40],
			[AppDelegate SizeIcon40])];
	}

	- (void) tap {
		[self removeFromSuperview];
	}
@end
