//
//  ABCTableViewBase.m
//  your-dpd
//
//  Created by Richard Simkins on 18/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCTableViewBase.h"

@interface ABCTableViewBase()
@end

@implementation ABCTableViewBase
	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y {

		[self setFrame:CGRectMake(
			x,
			y,
			[self sizeView].width,
			[self sizeView].height)];

		return [self sizeView].height;
	}

	- (NSArray*) viewCollectionForScrollViewForeground {
		return nil;
	}
@end
