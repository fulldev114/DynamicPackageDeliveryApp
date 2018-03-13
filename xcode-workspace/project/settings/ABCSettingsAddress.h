//
//  ABCSettingsAddress.h
//  your-dpd
//
//  Created by Richard Simkins on 01/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCDataAddress.h"
#import "ABCViewBase.h"

@interface ABCSettingsAddress : ABCViewBase
	- (instancetype)
		initWithDataAddress:(ABCDataAddress*)dataAddress
		andSizeView:(CGSize)sizeView;
@end
