//
//  ABCSettingsAddressNew.h
//  your-dpd
//
//  Created by Richard Simkins on 02/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCSettingsAddressNew : ABCViewBase
	typedef void (^BlockSettingsAddressNew)();

	- (instancetype) initWithBlock:(BlockSettingsAddressNew)block;
@end
