//
//  ABCConfirm.h
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABCConfirm : UIView
	typedef void (^BlockConfirm)();

	- (CGFloat) SizeViewHeight;
	- (CGFloat) SizeViewWidth;

	- (instancetype)
		initWithText:(NSString*)text
		andBlock:(BlockConfirm)block;
@end
