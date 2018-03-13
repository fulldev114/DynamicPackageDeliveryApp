//
//  ABCMenu.m
//  your-dpd
//
//  Created by Richard Simkins on 08/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCMenu.h"

#import "ABCMenuCollection.h"
#import "AppDelegate.h"

@interface ABCMenu()
	@property (nonatomic, strong) BlockMenu blockMenu;
	@property (nonatomic) CGFloat buttonHeight;
	@property (nonatomic) CGFloat top;
@end

@implementation ABCMenu
	- (UIFont*) FontTitle {
		return [UIFont systemFontOfSize:16.0f];
	}

	- (CGFloat) SizePaddingHorizontal {
		return 14.0f;
	}

	- (CGFloat) SizePaddingLeft {
		return 25.0f;
	}

	+ (CGFloat) SizeViewHeight {
		return 192.0f;
	}

	- (instancetype) initWithBlockMenu:(BlockMenu)blockMenu {
		self = [super initWithFrame:CGRectMake(
			0.0f,
			0.0f - [ABCMenu SizeViewHeight],
			[[UIScreen mainScreen] bounds].size.width,
			[ABCMenu SizeViewHeight])];

		if (!self) return nil;

		[self setBlockMenu:blockMenu];

		[self Initialise];

		return self;
	}

	- (void) Initialise {
		[self setBackgroundColor:[AppDelegate ColourAppRed]];

		[self setTop:[AppDelegate SizeStatusBarHeight] + [self SizePaddingHorizontal]];
		[self setButtonHeight:[ABCMenu SizeViewHeight] - [AppDelegate SizeStatusBarHeight] - ([self SizePaddingHorizontal] * 2.0f)];
		[self setButtonHeight:[self buttonHeight] / 3.0f];

		[self
			labelWithTitle:NSLocalizedString(@"Help", nil)
//			andSelector:@selector(tapHelp)
			andIndex:[ABCMenuCollection IndexHelp]];
		[self
			labelWithTitle:NSLocalizedString(@"Settings", nil)
//			andSelector:@selector(tapSettings)
			andIndex:[ABCMenuCollection IndexSettings]];
		[self
			labelWithTitle:NSLocalizedString(@"Your Deliveries", nil)
//			andSelector:@selector(tapYourDeliveries)
			andIndex:[ABCMenuCollection IndexYourDeliveries]];
	}

	- (void)
		labelWithTitle:(NSString*)titleString
		andIndex:(NSUInteger)index {

		UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
		[self addSubview:button];
		[button
			addTarget:self
			action:@selector(tap:)
			forControlEvents:UIControlEventTouchUpInside];
		[button setContentEdgeInsets:UIEdgeInsetsMake(
			0.0f,
			[self SizePaddingLeft],
			0.0f,
			0.0f)];
		[button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
		[button setFrame:CGRectMake(
			0.0f,
			[self top] + ([self buttonHeight] * ((CGFloat)index)),
			[[UIScreen mainScreen] bounds].size.width,
			[self buttonHeight])];
		[button setTag:index];
		[button setTitle:titleString forState:UIControlStateNormal];
		[[button titleLabel] setFont:[self FontTitle]];
		[[button titleLabel] setTextColor:[UIColor whiteColor]];
	}

	- (void) tap:(id)sender {
		[self blockMenu]([sender tag]);
	}

/*	- (void) tapHelp {
		NSLog(@"Tap help.");
		[[self menuCollection] setSelectedIndex:[[self menuCollection] IndexHelp]];
	}

	- (void) tapSettings {
		NSLog(@"Tap settings.");
		[[self menuCollection] setSelectedIndex:[[self menuCollection] IndexSettings]];
	}

	- (void) tapYourDeliveries {
		NSLog(@"Tap your deliveries.");
		[[self menuCollection] setSelectedIndex:[[self menuCollection] IndexYourDeliveries]];
	}*/
@end
