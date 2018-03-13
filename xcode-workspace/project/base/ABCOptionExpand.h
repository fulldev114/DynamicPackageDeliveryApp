//
//  ABCOptionExpand.h
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCOptionExpand : ABCViewBase
	typedef void (^BlockExpandState)(BOOL expanded);

	+ (CGFloat) Delay;

	- (instancetype)
		initWithText:(NSString*)text
		andBlock:(BlockExpandState)block;
	- (void) setExpandState:(BOOL)expandState;
@end
