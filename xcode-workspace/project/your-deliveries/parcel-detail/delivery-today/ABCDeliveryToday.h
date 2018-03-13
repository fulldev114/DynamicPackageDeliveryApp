//
//  ABCDeliveryToday.h
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewControllerBase.h"
#import "ABCDataParcel.h"

@interface ABCDeliveryToday : ABCViewControllerBase
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel;
@end
