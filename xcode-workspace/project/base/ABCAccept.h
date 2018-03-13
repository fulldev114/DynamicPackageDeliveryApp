//
//  ABCAccept.h
//  your-dpd
//
//  Created by Richard Simkins on 26/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCAccept : ABCViewBase
	typedef void (^BlockAccept)();

	- (instancetype)
		initWithTitle:(NSString*)title
		andBlockAccept:(BlockAccept)blockAccept;
	- (void) setSelected:(BOOL)selected;
@end
