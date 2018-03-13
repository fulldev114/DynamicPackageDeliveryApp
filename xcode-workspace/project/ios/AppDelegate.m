//
//  AppDelegate.m
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "AppDelegate.h"

#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>

#import "ABCMenu.h"
#import "ABCMenuCollection.h"

@interface AppDelegate()
	@property (nonatomic) ABCViewControllerBase* currentViewController;
	@property (nonatomic) ABCMenu* menu;
	@property (nonatomic) UIButton* menuDismiss;
	@property (nonatomic) CGFloat statusBarHeight;
@end

@implementation AppDelegate
	+ (UIColor*) ColourAppBlack {
		return [UIColor
			colorWithRed:53.0f/255.0f
			green:52.0f/255.0f
			blue:54.0f/255.0f
			alpha:1.0f];
	}

	+ (UIColor*) ColourAppBlackLight {
		return [UIColor
			colorWithRed:65.0f/255.0f
			green:64.0f/255.0f
			blue:66.0f/255.0f
			alpha:1.0f];
	}

	+ (UIColor*) ColourAppGreen {
		return [UIColor
			colorWithRed:113.0f/255.0f
			green:189.0f/255.0f
			blue:31.0f/255.0f
			alpha:1.0f];
	}

	+ (UIColor*) ColourAppGrey {
		return [UIColor
			colorWithRed:206.0f/255.0f
			green:209.0f/255.0f
			blue:208.0f/255.0f
			alpha:1.0f];
	}

	+ (UIColor*) ColourAppGreyDark {
		return [UIColor
			colorWithRed:129.0f/255.0f
			green:130.0f/255.0f
			blue:133.0f/255.0f
			alpha:1.0f];
	}

	+ (UIColor*) ColourAppGreyLight {
		return [UIColor
			colorWithRed:231.0f/255.0f
			green:231.0f/255.0f
			blue:231.0f/255.0f
			alpha:1.0f];
	}

	+ (UIColor*) ColourAppRed {
		return [UIColor
			colorWithRed:220.0f/255.0f
			green:0.0f/255.0f
			blue:50.0f/255.0f
			alpha:1.0f];
	}

	- (CGFloat) DelayMenuOpen {
		return 0.3f;
	}

	+ (UIFont*) FontExtraLightWithSize:(CGFloat)size {
		return [UIFont
			fontWithName:@"PlutoSansDPDExtraLight"
			size:size];
	}

	+ (UIFont*) FontLightWithSize:(CGFloat)size {
		return [UIFont
			fontWithName:@"PlutoSansDPDLight"
			size:size];
	}

	+ (UIFont*) FontRegularWithSize:(CGFloat)size {
		UIFont* font = [UIFont
			fontWithName:@"PlutoSansDPDRegular"
			size:size];

		return font;
	}

	+ (UIFont*) FontThinWithSize:(CGFloat)size {
		return [UIFont
			fontWithName:@"PlutoSansDPDThin"
			size:size];
	}

	+ (CGFloat) Pi {
		return 3.141592653589f;
	}

	+ (CGFloat) SizeCornerRadius {
		return 8.0f;
	}

	+ (CGFloat) SizeIcon18 {
		return 18.0f;
	}

	+ (CGFloat) SizeIcon22 {
		return 22.0f;
	}

	+ (CGFloat) SizeIcon25 {
		return 25.0f;
	}

	+ (CGFloat) SizeIcon40 {
		return 40.0f;
	}

	+ (CGFloat) SizeNavigationBarAndStatusBarHeight {
		return 64.0f;
	}

	+ (CGFloat) SizeNavigationBarHeight {
		return 44.0f;
	}

	+ (CGFloat) SizeNavigationBarIcon {
		return 25.0f;
	}

	+ (CGFloat) SizePaddingFromSides {
		return 16.0f;
	}

	+ (CGFloat) SizePaddingFromSidesThin {
		return 8.0f;
	}

	+ (CGFloat) SizeSeparationThickness {
		return 1.0f;
	}

	+ (CGFloat) SizeStatusBarHeight {
		return 20.0f;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		// # Must be set before willChangeStatusBarFrame is called.
		[self setStatusBarHeight:[AppDelegate SizeStatusBarHeight]];

		return self;
	}

	- (void) applicationDidBecomeActive:(UIApplication*)application {
	}

	- (void) applicationDidEnterBackground:(UIApplication*)application {
	}

	- (BOOL)
		application:(UIApplication*)application
		didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {

		[Fabric with:@[CrashlyticsKit]];

		[self setWindow: [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
		[[self window] setBackgroundColor: [UIColor whiteColor]];

		ABCMenuCollection* menuCollection = [[ABCMenuCollection alloc] init];
		[self setNavigationController:[[UINavigationController alloc] initWithRootViewController:menuCollection]];

		[[self window] setRootViewController:[self navigationController]];
		[[self window] makeKeyAndVisible];
		// # Correct a bug in iOS 8 that mishandles the window's frame. Vital for the correct
		//   functionality of the menu.
		[[self window] setFrame:[[UIScreen mainScreen] bounds]];

		[self setMenu:[[ABCMenu alloc] initWithBlockMenu:^(NSUInteger index) {
			[menuCollection setSelectedIndex:index];
			[self MenuClose];
		}]];
		[[self window] addSubview:[self menu]];

		[self setMenuDismiss:[UIButton buttonWithType:UIButtonTypeCustom]];
		[[self window] addSubview:[self menuDismiss]];
		[[self menuDismiss]
			addTarget:self
			action:@selector(tapMenuDismiss)
			forControlEvents:UIControlEventTouchUpInside];
		[[self menuDismiss] setHidden:YES];

		return YES;
	}

	- (BOOL)
		application:(UIApplication*)application
		openURL:(NSURL*)url
		sourceApplication:(NSString*)sourceApplication
		annotation:(id)annotation {

		return YES;
	}

	- (void)
		application:(UIApplication*)application
		willChangeStatusBarFrame:(CGRect)newStatusBarFrame {

		[self setStatusBarHeight:newStatusBarFrame.size.height];
		[self MenuClose];

		if (![self currentViewController]) return;

		CGFloat difference = newStatusBarFrame.size.height > [AppDelegate SizeStatusBarHeight]
			? -[AppDelegate SizeStatusBarHeight]
			: [AppDelegate SizeStatusBarHeight];
		[[self currentViewController] updateStatusBarHeightChangesWithDifference:difference];
	}

	- (void) applicationWillEnterForeground:(UIApplication*)application {
	}

	- (void) applicationWillResignActive:(UIApplication*)application {
	}

	- (void) applicationWillTerminate:(UIApplication*)application {
	}

	+ (void) currentViewControllerSet:(ABCViewControllerBase*)viewController {
		AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
		[appDelegate setCurrentViewController:viewController];
	}

	- (void) MenuClose {
		[[self menuDismiss] setFrame:CGRectMake(
			0.0f,
			0.0f,
			[[UIScreen mainScreen] bounds].size.width,
			[[UIScreen mainScreen] bounds].size.height)];

		[UIView
			animateWithDuration:[self DelayMenuOpen]
			animations:^{
				CGFloat statusBarDifference = [self statusBarHeight] - [AppDelegate SizeStatusBarHeight];
				[[[self navigationController] view] setFrame:CGRectMake(
					0.0f,
					statusBarDifference,
					[[[self navigationController] view] frame].size.width,
					[[[self navigationController] view] frame].size.height)];
				[[self menu] setFrame:CGRectMake(
					0.0f,
					statusBarDifference - [ABCMenu SizeViewHeight],
					[[self menu] frame].size.width,
					[[self menu] frame].size.height)];
			} completion:^(BOOL finished) {
				[[self menuDismiss] setHidden:YES];
			}];
	}

	- (void) MenuOpen {
		CGFloat statusBarDifference = [self statusBarHeight] - [AppDelegate SizeStatusBarHeight];

		[[self menuDismiss] setFrame:CGRectMake(
			0.0f,
			statusBarDifference + [ABCMenu SizeViewHeight],
			[[UIScreen mainScreen] bounds].size.width,
			[[UIScreen mainScreen] bounds].size.height - statusBarDifference - [ABCMenu SizeViewHeight])];
		[[self menuDismiss] setHidden:NO];

		[UIView
			animateWithDuration:[self DelayMenuOpen]
			animations:^{
				[[[self navigationController] view] setFrame:CGRectMake(
					0.0f,
					statusBarDifference + [ABCMenu SizeViewHeight],
					[[[self navigationController] view] frame].size.width,
					[[[self navigationController] view] frame].size.height)];
				[[self menu] setFrame:CGRectMake(
					0.0f,
					statusBarDifference,
					[[self menu] frame].size.width,
					[[self menu] frame].size.height)];
			}];
	}

	- (void) tapMenuDismiss {
		AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
		[appDelegate MenuClose];
	}
@end
