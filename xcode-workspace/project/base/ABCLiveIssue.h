//
//  ABCLiveIssue.h
//  your-dpd
//
//  Created by Richard Simkins on 21/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCViewBase.h"

@interface ABCLiveIssue : ABCViewBase
	@property (nonatomic) NSString* text;

	- (void) initialise;
@end
