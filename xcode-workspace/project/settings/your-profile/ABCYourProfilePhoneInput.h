//
//  ABCYourProfilePhoneInput.h
//  your-dpd
//
//  Created by Richard Simkins on 11/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCYourProfilePhoneInput : ABCViewBase
	typedef void (^BlockYourProfilePhoneInputChange)(BOOL valueOriginal);
	typedef void (^BlockYourProfilePhoneInputEditEnd)();
	typedef void (^BlockYourProfilePhoneInputEditStart)();

	- (instancetype)
		initWithValue:(NSString*)value
		andBlockEditStart:(BlockYourProfilePhoneInputEditStart)blockEditStart
		andBlockEditEnd:(BlockYourProfilePhoneInputEditEnd)blockEditEnd
		andBlockChange:(BlockYourProfilePhoneInputChange)blockChange;
	- (void) commit;
	- (void) revert;
@end
