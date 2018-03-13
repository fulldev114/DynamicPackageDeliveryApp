//
//  ABCParcelDetailOptionCollectionExpand.h
//  your-dpd
//
//  Created by Richard Simkins on 20/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

#import "ABCDataParcel.h"

@interface ABCParcelDetailOptionCollectionExpand : ABCViewBase;
	typedef void (^BlockExpand)(CGFloat difference);

	- (instancetype)
		initWithNavigationController:(UINavigationController*)navigationController
		andDataParcel:(ABCDataParcel*)dataParcel
		andBlockExpand:(BlockExpand)blockExpand;
@end
