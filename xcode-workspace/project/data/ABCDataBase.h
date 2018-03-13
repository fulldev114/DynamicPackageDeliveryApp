//
//  ABCDataBase.h
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <Foundation/Foundation.h>

// # A base class not a database.
@interface ABCDataBase : NSObject
	- (BOOL)
		validArrayInDictionary:(NSDictionary*)dictionary
		forKey:(NSString*)key;
	- (BOOL)
		validDictionaryInDictionary:(NSDictionary*)dictionary
		forKey:(NSString*)key;
	- (BOOL)
		validValueInDictionary:(NSDictionary*)dictionary
		forKey:(NSString*)key;
@end