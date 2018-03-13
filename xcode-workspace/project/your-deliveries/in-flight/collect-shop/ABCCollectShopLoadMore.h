//
//  ABCCollectShopLoadMore.h
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCButtonBase.h"

@interface ABCCollectShopLoadMore : ABCButtonBase
	typedef void (^BlockLoadMore)();

	- (instancetype)
		initWithText:(NSString*)text
		andBlockLoadMore:(BlockLoadMore)blockLoadMore;
@end
