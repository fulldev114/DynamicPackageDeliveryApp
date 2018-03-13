//
//  ABCMenu.h
//  your-dpd
//
//  Created by Richard Simkins on 08/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ABCMenu : UIView
	typedef void (^BlockMenu)(NSUInteger index);

	+ (CGFloat) SizeViewHeight;

	- (instancetype) initWithBlockMenu:(BlockMenu)blockMenu;
@end
