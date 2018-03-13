//
//  ABCDataTimeslot.h
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ABCDataBase.h"

@interface ABCDataTimeslot : ABCDataBase
	@property (nonatomic) NSString* timeslot;

	- (instancetype) initWithNSDictionary:(NSDictionary*)dictionary;
@end