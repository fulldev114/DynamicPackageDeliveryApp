//
//  ABCDeliverNeighbourAddress.h
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

#import "ABCDataAddress.h"
#import "ABCRadio.h"

@interface ABCDeliverNeighbourAddress : ABCViewBase
	@property (nonatomic) ABCRadio* radio;

	- (instancetype)
		initWithDataAddress:(ABCDataAddress*)dataAddress
		andSizeView:(CGSize)sizeView;
@end
