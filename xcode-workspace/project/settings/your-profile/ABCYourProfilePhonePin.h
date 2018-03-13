//
//  ABCYourProfilePhonePin.h
//  your-dpd
//
//  Created by Richard Simkins on 11/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCYourProfilePhonePin : ABCViewBase
	typedef void (^BlockYourProfilePhonePinEditingEnd)();
	typedef void (^BlockYourProfilePhonePinConfirm)(NSString* pinNumber);

	- (instancetype)
		initWithPaddingTop:(CGFloat)paddingTop
		andBlockEditingEnd:(BlockYourProfilePhonePinEditingEnd)blockEditingEnd
		andBlockConfirm:(BlockYourProfilePhonePinConfirm)blockConfirm;
	- (void) pinReset;
	- (void) resign;
@end
