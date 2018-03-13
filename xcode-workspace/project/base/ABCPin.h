//
//  ABCPin.h
//  your-dpd
//
//  Created by Richard Simkins on 15/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABCPin : UIView
	+ (CGFloat) SizeViewHeight;
	+ (CGFloat) SizeViewWidth;

	- (instancetype) initWithImage:(NSString*)image;
	- (instancetype) initWithIndex:(NSUInteger)index;
	- (instancetype) initWithText:(NSString*)text;
	- (void) colourSet:(UIColor*)colour;
@end
