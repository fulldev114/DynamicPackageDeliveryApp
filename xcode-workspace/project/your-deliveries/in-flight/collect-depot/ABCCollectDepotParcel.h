//
//  ABCCollectDepotParcel.h
//  your-dpd
//
//  Created by Richard Simkins on 27/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

#import "ABCDataParcel.h"

@interface ABCCollectDepotParcel : ABCViewBase
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel;
@end
