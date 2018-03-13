//
//  ABCScrollView.h
//  your-dpd
//
//  Created by Richard Simkins on 08/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABCScrollView : UIScrollView<UITextViewDelegate>
	typedef void (^BlockScrollViewKeyboardStateChange)();

	- (instancetype) initWithBlockKeyboardStateChange:(BlockScrollViewKeyboardStateChange)blockKeyboardStateChange;
	- (void) backgroundAddSubView:(UIView*)subView;
	- (void) foregroundAddSubViewCollection:(NSArray*)subViewCollection;
	- (void)
		setFrameHeight:(CGFloat)frameHeight
		andContentHeight:(CGFloat)contentHeight;
	- (void) tapKeyboardDismiss;
@end
