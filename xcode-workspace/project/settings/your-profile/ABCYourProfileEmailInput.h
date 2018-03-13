//
//  ABCYourProfileEmailInput.h
//  your-dpd
//
//  Created by Richard Simkins on 09/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCYourProfileEmailInput : ABCViewBase
	typedef void (^BlockYourProfileEmailInputChange)(BOOL valueOriginal);
	typedef void (^BlockYourProfileEmailInputEditEnd)();
	typedef void (^BlockYourProfileEmailInputEditStart)();

	- (instancetype)
		initWithValue:(NSString*)value
		andBlockEditStart:(BlockYourProfileEmailInputEditStart)blockEditStart
		andBlockEditEnd:(BlockYourProfileEmailInputEditEnd)blockEditEnd
		andBlockChange:(BlockYourProfileEmailInputChange)blockChange;
	- (void) commit;
	- (void) revert;
@end
