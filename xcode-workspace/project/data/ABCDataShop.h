//
//  ABCDataShop.h
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ABCDataBase.h"

@interface ABCDataShop : ABCDataBase
	@property (nonatomic) NSString* addressSingleLine;
	@property (nonatomic) NSString* distanceMiles;
	@property (nonatomic) NSString* placeName;

	- (instancetype) initWithNSDictionary:(NSDictionary*)dictionary;
@end