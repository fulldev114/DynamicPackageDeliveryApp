//
//  ABCCollectShopDetail.h
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCDataShop.h"
#import "ABCRadio.h"
#import "ABCViewBase.h"

@interface ABCCollectShopDetail : ABCViewBase
	typedef void (^BlockShopSelect)(ABCDataShop* dataShop);
	typedef void (^BlockShopTimes)(ABCDataShop* dataShop);

	@property (nonatomic) ABCRadio* radio;

	- (instancetype)
		initWithDataShop:(ABCDataShop*)dataShop
		andIndex:(NSUInteger)index
		andSizeView:(CGSize)sizeView
		andBlockShopSelect:(BlockShopSelect)blockShopSelect
		andBlockShopTimes:(BlockShopTimes)blockShopTimes;
@end
