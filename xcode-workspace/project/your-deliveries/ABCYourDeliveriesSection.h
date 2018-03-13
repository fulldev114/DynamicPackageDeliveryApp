//
//  ABCYourDeliveriesSection.h
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCYourDeliveriesSection : ABCViewBase
	+ (NSInteger) Total;

	- (instancetype)
		initWithIndex:(NSInteger)index
		andCount:(NSInteger)count
		andSizeView:(CGSize)sizeView;
@end
