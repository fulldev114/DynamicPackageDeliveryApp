//
//  ABCDeliveryCompleteGallery.h
//  your-dpd
//
//  Created by Richard Simkins on 21/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCDeliveryCompleteGallery : ABCViewBase
	typedef void (^BlockItemTapped)(NSInteger tag);

	- (instancetype) initWithBlockItemTapped:(BlockItemTapped)blockItemTapped;
@end
