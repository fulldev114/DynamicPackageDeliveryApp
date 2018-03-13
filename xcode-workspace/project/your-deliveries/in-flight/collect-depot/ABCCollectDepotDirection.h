//
//  ABCCollectDepotDirection.h
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

#import "ABCDataDirection.h"

@interface ABCCollectDepotDirection : ABCViewBase
	- (instancetype)
		initWithDataDirection:(ABCDataDirection*)dataDirection
		andIndex:(NSUInteger)index
		andSizeView:(CGSize)sizeView;
@end
