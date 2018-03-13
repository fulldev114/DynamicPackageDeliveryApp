//
//  ABCNotice.h
//  your-dpd
//
//  Created by Richard Simkins on 19/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCNotice : ABCViewBase
	- (instancetype)
		initWithText:(NSString*)text
		andIcon:(BOOL)icon;
@end
