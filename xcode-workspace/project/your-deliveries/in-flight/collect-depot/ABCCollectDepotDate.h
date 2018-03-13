//
//  ABCCollectDepotDate.h
//  your-dpd
//
//  Created by Richard Simkins on 27/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

#import "ABCDataDate.h"
#import "ABCRadio.h"

@interface ABCCollectDepotDate : ABCViewBase
	@property (nonatomic) ABCRadio* radio;

	- (instancetype)
		initWithDataDate:(ABCDataDate*)dataDate
		andSizeView:(CGSize)sizeView;
@end
