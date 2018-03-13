//
//  ABCYourProfilePhoneVerify.h
//  your-dpd
//
//  Created by Richard Simkins on 11/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCYourProfilePhoneVerify : ABCViewBase
	typedef void (^BlockYourProfilePhoneVerifyTap)();

	- (instancetype) initWithBlockTap:(BlockYourProfilePhoneVerifyTap)blockTap;
@end