//
//  ABCMenuCollection.m
//  your-dpd
//
//  Created by Richard Simkins on 01/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCMenuCollection.h"

#import "ABCHelp.h"
#import "ABCSettings.h"
#import "ABCYourDeliveries.h"
#import "AppDelegate.h"

@interface ABCMenuCollection()
	@property (nonatomic) ABCHelp* help;
	@property (nonatomic) ABCSettings* settings;
	@property (nonatomic) ABCYourDeliveries* yourDeliveries;
@end

@implementation ABCMenuCollection
	+ (NSUInteger) IndexHelp {
		return 2;
	}

	+ (NSUInteger) IndexSettings {
		return 1;
	}

	+ (NSUInteger) IndexYourDeliveries {
		return 0;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[[[self moreNavigationController] navigationBar] setHidden:YES];

		return self;
	}

	- (void) setSelectedIndex:(NSUInteger)selectedIndex {
		if (selectedIndex == [ABCMenuCollection IndexHelp]) {
			[self setTitle:NSLocalizedString(@"Help", nil)];
		} else if (selectedIndex == [ABCMenuCollection IndexSettings]) {
			[self setTitle:NSLocalizedString(@"Settings", nil)];
		} else if (selectedIndex == [ABCMenuCollection IndexYourDeliveries]) {
			[self setTitle:NSLocalizedString(@"Your deliveries", nil)];
		}

		[super setSelectedIndex:selectedIndex];
	}

	- (void) viewDidLayoutSubviews {
		[super viewDidLayoutSubviews];

		[self setupNavigationBar];
		[self setupNavigationBarDefaults];
	}

	- (void) viewDidLoad {
		[super viewDidLoad];
		[[self tabBar] setAlpha:0.0f];

		[self setHelp:[[ABCHelp alloc] init]];
		[self setSettings:[[ABCSettings alloc] init]];
		[self setYourDeliveries:[[ABCYourDeliveries alloc] init]];

		NSMutableArray* viewControllerCollection = [[NSMutableArray alloc] init];

		for (NSUInteger i = 0; i < 3; i++) {
			if (i == [ABCMenuCollection IndexHelp]) {
				[viewControllerCollection addObject:[self help]];
			} else if (i == [ABCMenuCollection IndexSettings]) {
				[viewControllerCollection addObject:[self settings]];
			} else if (i == [ABCMenuCollection IndexYourDeliveries]) {
				[viewControllerCollection addObject:[self yourDeliveries]];
			}
		}

		[self setViewControllers:viewControllerCollection];
		[self setSelectedIndex:[ABCMenuCollection IndexSettings]];
	}

	- (void) setupNavigationBar {
		[[self navigationItem] setLeftBarButtonItem:[[UIBarButtonItem alloc]
			initWithImage:[UIImage imageNamed:@"navigation-bar-menu.png"]
			style:UIBarButtonItemStylePlain
			target:self
			action:@selector(tapNavigationItemMenu)]];

		UIImageView* logoDpd = [[UIImageView alloc] initWithFrame:CGRectMake(
			[[UIScreen mainScreen] bounds].size.width - [AppDelegate SizeNavigationBarIcon] - ([AppDelegate SizeNavigationBarAndStatusBarHeight] / 4.0f),
			([AppDelegate SizeNavigationBarHeight] - [AppDelegate SizeNavigationBarIcon]) / 2.0f,
			[AppDelegate SizeNavigationBarIcon],
			[AppDelegate SizeNavigationBarIcon])];
		[[[self navigationController] navigationBar] addSubview:logoDpd];
		[logoDpd setBackgroundColor:[UIColor yellowColor]];
		[logoDpd setImage:[UIImage imageNamed:@"navigation-bar-dpd-logo.png"]];
	}

	- (void) setupNavigationBarDefaults {
		if (![self navigationController]) return;

//		[[[self navigationController] navigationBar] setBarTintColor:[AppDelegate ColourAppBlue]];
//		[[[self navigationController] navigationBar] setBarStyle:UIBarStyleBlack];
		[[[self navigationController] navigationBar] setTintColor:[AppDelegate ColourAppBlack]];
		[[[self navigationController] navigationBar] setTitleTextAttributes:@{NSForegroundColorAttributeName:[AppDelegate ColourAppBlack]}];
		[[[self navigationController] navigationBar] setTranslucent:NO];

		[[self navigationItem] setBackBarButtonItem:[[UIBarButtonItem alloc]
			initWithTitle:@"Back"
			style:UIBarButtonItemStylePlain
			target:nil
			action:nil]];
	}

	- (void) tapNavigationItemMenu {
		AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
		[appDelegate MenuOpen];
	}
@end
