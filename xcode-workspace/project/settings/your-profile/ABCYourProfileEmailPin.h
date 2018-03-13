//
//  ABCYourProfileEmailPin.h
//  your-dpd
//
//  Created by Richard Simkins on 09/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCYourProfileEmailPin : ABCViewBase
	typedef void (^BlockYourProfileEmailPinEditingEnd)();
	typedef void (^BlockYourProfileEmailPinConfirm)(NSString* pinNumber);

	- (instancetype)
		initWithPaddingTop:(CGFloat)paddingTop
		andBlockEditingEnd:(BlockYourProfileEmailPinEditingEnd)blockEditingEnd
		andBlockConfirm:(BlockYourProfileEmailPinConfirm)blockConfirm;
	- (void) pinReset;
	- (void) resign;
@end
