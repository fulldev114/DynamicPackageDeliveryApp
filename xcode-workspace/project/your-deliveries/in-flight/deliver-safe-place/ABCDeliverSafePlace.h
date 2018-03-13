//
//  ABCDeliverSafePlace.h
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCDataParcel.h"
#import "ABCViewControllerBase.h"

@interface ABCDeliverSafePlace : ABCViewControllerBase
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel;
@end
