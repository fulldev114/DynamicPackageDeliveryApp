//
//  ABCDeliverSafePlaceInstruction.h
//  your-dpd
//
//  Created by Richard Simkins on 26/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCDeliverSafePlaceInstruction : ABCViewBase
	- (void) bringToTopOfScrollView:(UIScrollView*)scrollview;
	- (void) resign;
	- (void) textViewAddToScrollView:(UIScrollView*)scrollview;
@end
