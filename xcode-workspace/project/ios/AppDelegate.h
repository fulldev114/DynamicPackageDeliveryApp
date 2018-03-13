//
//  AppDelegate.h
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewControllerBase.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
	+ (UIColor*) ColourAppBlack;
	+ (UIColor*) ColourAppBlackLight;
	+ (UIColor*) ColourAppGreen;
	+ (UIColor*) ColourAppGrey;
	+ (UIColor*) ColourAppGreyDark;
	+ (UIColor*) ColourAppGreyLight;
	+ (UIColor*) ColourAppRed;
	+ (UIFont*) FontExtraLightWithSize:(CGFloat)size;
	+ (UIFont*) FontLightWithSize:(CGFloat)size;
	+ (UIFont*) FontRegularWithSize:(CGFloat)size;
	+ (UIFont*) FontThinWithSize:(CGFloat)size;
	+ (CGFloat) Pi;
	+ (CGFloat) SizeCornerRadius;
	+ (CGFloat) SizeIcon18;
	+ (CGFloat) SizeIcon22;
	+ (CGFloat) SizeIcon25;
	+ (CGFloat) SizeIcon40;
	+ (CGFloat) SizeNavigationBarAndStatusBarHeight;
	+ (CGFloat) SizeNavigationBarHeight;
	+ (CGFloat) SizeNavigationBarIcon;
	+ (CGFloat) SizePaddingFromSides;
	+ (CGFloat) SizePaddingFromSidesThin;
	+ (CGFloat) SizeSeparationThickness;
	+ (CGFloat) SizeStatusBarHeight;

	@property (nonatomic) UINavigationController* navigationController;
	@property (nonatomic) UIWindow* window;

	+ (void) currentViewControllerSet:(ABCViewControllerBase*)viewController;
	- (void) MenuOpen;
@end
