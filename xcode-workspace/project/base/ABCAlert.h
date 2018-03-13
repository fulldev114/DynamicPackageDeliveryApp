//
//  ABCAlert.h
//  your-dpd
//
//  Created by Richard Simkins on 11/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCAlert : ABCViewBase
	@property (nonatomic) SEL selector;
	@property (nonatomic) NSString* text;

	- (void) initialise;
@end
