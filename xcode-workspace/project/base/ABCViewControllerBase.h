//
//  ABCViewControllerBase.h
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABCViewControllerBase : UIViewController<UIAlertViewDelegate>
	typedef void (^BlockConfirm)();

	- (void)
		confirmWithTitle:(NSString*)title
		andMessage:(NSString*)message;
	- (void)
		confirmWithTitle:(NSString*)title
		andMessage:(NSString*)message
		andBlockConfirm:(BlockConfirm)blockConfirm;
	- (void)
		confirmWithTitle:(NSString*)title
		andMessage:(NSString*)message
		andCancel:(NSString*)cancel
		andDestructive:(NSString*)destructive
		andBlockConfirm:(BlockConfirm)blockConfirm;
	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference;
@end
