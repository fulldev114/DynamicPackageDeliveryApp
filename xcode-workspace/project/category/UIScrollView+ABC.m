//
//  UIScrollView+ABC.m
//  your-dpd
//
//  Created by Richard Simkins on 21/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "UIScrollView+ABC.h"

@implementation UIScrollView(ABC)
	- (void) setContentOffsetDifference:(CGFloat)difference {
		if ([self contentSize].height <= [self frame].size.height) return;

		[self setContentOffset:CGPointMake(
			[self contentOffset].x,
			[self contentOffset].y + difference)];
	}
@end
