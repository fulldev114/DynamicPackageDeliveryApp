//
//  ABCBasicAddressType.h
//  your-dpd
//
//  Created by Richard Simkins on 12/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

#import "ABCRadio.h"

@interface ABCBasicAddressType : ABCViewBase
	@property (nonatomic) ABCRadio* radio;

	- (instancetype)
		initWithData:(NSString*)data
		andSizeView:(CGSize)sizeView;
@end
