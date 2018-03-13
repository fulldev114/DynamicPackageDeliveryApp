//
//  ABCDataParcelLocation.h
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ABCDataBase.h"

@interface ABCDataParcelLocation : ABCDataBase
	@property (nonatomic) NSString* eventDate;
	@property (nonatomic) NSString* eventDescription;
	@property (nonatomic) NSString* placeName;

	- (instancetype) initWithNSDictionary:(NSDictionary*)dictionary;
@end