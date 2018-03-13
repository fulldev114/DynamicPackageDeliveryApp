//
//  ABCAddressEditDanger.h
//  your-dpd
//
//  Created by Richard Simkins on 12/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCAddressEditDanger : ABCViewBase
	typedef void (^BlockAddressEditDanger)();

	- (instancetype) initWithBlock:(BlockAddressEditDanger)block;
@end
