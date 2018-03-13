//
//  ABCCollectShopParcel.h
//  your-dpd
//
//  Created by Richard Simkins on 18/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCDataParcel.h"
#import "ABCViewBase.h"

@interface ABCCollectShopParcel : ABCViewBase
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel;
@end
