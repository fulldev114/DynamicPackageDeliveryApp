//
//  ABCParcelDetailLocationCollectionExpand.h
//  your-dpd
//
//  Created by Richard Simkins on 20/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCParcelDetailLocationCollectionExpand : ABCViewBase;
	typedef void (^BlockExpand)(CGFloat difference);

	- (instancetype) initWithBlockExpand:(BlockExpand)blockExpand;
@end
