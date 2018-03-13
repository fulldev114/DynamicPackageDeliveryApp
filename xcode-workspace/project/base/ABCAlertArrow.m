//
//  ABCAlertArrow.m
//  your-dpd
//
//  Created by Richard Simkins on 11/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCAlertArrow.h"

#import "AppDelegate.h"

@interface ABCAlertArrow()
@end

@implementation ABCAlertArrow
	- (CGFloat) SizeArrowHeight {
		return 12.0f;
	}

	- (CGFloat) SizeArrowWidth {
		return 20.0f;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setBackgroundColor:[UIColor clearColor]];

		return self;
	}

	- (void) drawRect:(CGRect)rect {
		UIBezierPath* path = [[UIBezierPath alloc] init];
		[path moveToPoint:CGPointMake(
			0.0f,
			[self SizeArrowHeight])];
		[path addLineToPoint:CGPointMake(
			[self SizeArrowWidth],
			[self SizeArrowHeight])];
		[path addLineToPoint:CGPointMake(
			[self SizeArrowWidth] / 2.0f,
			0.0f)];
		[[AppDelegate ColourAppRed] setFill];
		[path fill];
	}

	- (void) setPosition:(CGPoint)position {
		[self setFrame:CGRectMake(
			position.x - ([self SizeArrowWidth] / 2.0f),
			position.y - [self SizeArrowHeight],
			[self SizeArrowWidth],
			[self SizeArrowHeight])];
	}
@end
