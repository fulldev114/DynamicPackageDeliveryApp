//
//  ABCYourProfileEmailVerify.h
//  your-dpd
//
//  Created by Richard Simkins on 09/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCYourProfileEmailVerify : ABCViewBase
	typedef void (^BlockYourProfileEmailVerifyTap)();

	- (instancetype) initWithBlockTap:(BlockYourProfileEmailVerifyTap)blockTap;
@end