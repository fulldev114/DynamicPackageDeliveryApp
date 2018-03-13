//
//  ABCYourProfileEmail.h
//  your-dpd
//
//  Created by Richard Simkins on 09/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCYourProfileEmail : ABCViewBase
	typedef void (^BlockYourProfileEmailChange)();
	typedef void (^BlockYourProfileEmailConfirm)(NSString* pinNumber);

	- (instancetype)
		initWithValue:(NSString*)value
		andBlockChange:(BlockYourProfileEmailChange)blockChange
		andBlockConfirm:(BlockYourProfileEmailConfirm)blockConfirm;
	- (void) confirmComplete;
@end
