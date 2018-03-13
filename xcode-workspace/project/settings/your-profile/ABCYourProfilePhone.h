//
//  ABCYourProfilePhone.h
//  your-dpd
//
//  Created by Richard Simkins on 11/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCYourProfilePhone : ABCViewBase
	typedef void (^BlockYourProfilePhoneChange)();
	typedef void (^BlockYourProfilePhoneConfirm)(NSString* pinNumber);

	- (instancetype)
		initWithValue:(NSString*)value
		andBlockChange:(BlockYourProfilePhoneChange)blockChange
		andBlockConfirm:(BlockYourProfilePhoneConfirm)blockConfirm;
	- (void) confirmComplete;
@end
