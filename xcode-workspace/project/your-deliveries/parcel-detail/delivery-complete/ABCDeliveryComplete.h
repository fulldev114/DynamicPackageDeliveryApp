//
//  ABCDeliveryComplete.h
//  your-dpd
//
//  Created by Richard Simkins on 21/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewControllerBase.h"
#import "ABCDataParcel.h"

@interface ABCDeliveryComplete : ABCViewControllerBase
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel;
@end
