//
//  ABCDataDirection.h
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ABCDataBase.h"

@interface ABCDataDirection : ABCDataBase
	@property (nonatomic) NSString* directions;
	@property (nonatomic) NSNumber* distance;

	- (instancetype) initWithNSDictionary:(NSDictionary*)dictionary;
@end