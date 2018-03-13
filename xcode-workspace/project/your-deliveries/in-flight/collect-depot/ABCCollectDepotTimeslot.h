//
//  ABCCollectDepotTimeslot.h
//  your-dpd
//
//  Created by Richard Simkins on 27/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

#import "ABCDataTimeslot.h"
#import "ABCRadio.h"

@interface ABCCollectDepotTimeslot : ABCViewBase
	@property (nonatomic) ABCRadio* radio;

	- (instancetype)
		initWithDataTimeslot:(ABCDataTimeslot*)dataTimeslot
		andSizeView:(CGSize)sizeView;
@end
