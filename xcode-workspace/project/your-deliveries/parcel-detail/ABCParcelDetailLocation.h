//
//  ABCParcelDetailLocation.h
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCDataParcelLocation.h"
#import "ABCViewBase.h"

@interface ABCParcelDetailLocation : ABCViewBase
	+ (CGFloat) SizeColumnOneWidth;
	+ (CGFloat) SizeColumnTwoWidth;

	- (instancetype)
		initWithDataParcelLocation:(ABCDataParcelLocation*)dataParcelLocation
		andSizeView:(CGSize)sizeView;
@end
