//
//  ABCViewBase.h
//  your-dpd
//
//  Created by Richard Simkins on 18/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCScrollView.h"

@interface ABCViewBase : UIView
	@property (nonatomic) BOOL expanded;
	@property (nonatomic) CGSize sizeView;

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y;
	- (NSArray*) viewCollectionForScrollViewForeground;
@end
