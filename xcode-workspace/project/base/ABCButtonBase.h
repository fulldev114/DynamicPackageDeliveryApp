//
//  ABCButtonBase.h
//  your-dpd
//
//  Created by Richard Simkins on 19/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABCButtonBase : UIButton
	@property (nonatomic) BOOL expanded;
	@property (nonatomic) CGSize sizeView;

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y;
@end
