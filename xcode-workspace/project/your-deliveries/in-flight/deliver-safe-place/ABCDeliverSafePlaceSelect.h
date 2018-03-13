//
//  ABCDeliverSafePlaceSelect.h
//  your-dpd
//
//  Created by Richard Simkins on 22/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

#import "ABCRadio.h"

@interface ABCDeliverSafePlaceSelect : ABCViewBase
	@property (nonatomic) ABCRadio* radio;

	- (instancetype)
		initWithTitle:(NSString*)title
		andSizeView:(CGSize)sizeView;
@end
