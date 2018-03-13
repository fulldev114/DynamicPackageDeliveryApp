//
//  ABCOptionDrillDown.h
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCOptionDrillDown : ABCViewBase
	typedef void (^BlockDrillDown)();

	- (instancetype)
		initWithText:(NSString*)text
		andBlock:(BlockDrillDown)block;
	- (CGFloat) positionWithTop:(CGFloat)top;
@end
