//
//  ABCButtonBase.m
//  your-dpd
//
//  Created by Richard Simkins on 19/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCButtonBase.h"

@interface ABCButtonBase()
@end

@implementation ABCButtonBase
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
@end
