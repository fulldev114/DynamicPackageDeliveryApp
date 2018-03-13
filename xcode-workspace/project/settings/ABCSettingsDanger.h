//
//  ABCSettingsDanger.h
//  your-dpd
//
//  Created by Richard Simkins on 01/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCSettingsDanger : ABCViewBase
	typedef void (^BlockSettingsDanger)();

	- (instancetype) initWithBlock:(BlockSettingsDanger)block;
@end
