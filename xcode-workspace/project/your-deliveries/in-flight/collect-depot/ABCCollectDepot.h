//
//  ABCCollectDepot.h
//  your-dpd
//
//  Created by Richard Simkins on 15/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewControllerBase.h"

#import "ABCDataParcel.h"

@interface ABCCollectDepot : ABCViewControllerBase
	- (instancetype) initWithDataParcel:(ABCDataParcel*)dataParcel;
@end
