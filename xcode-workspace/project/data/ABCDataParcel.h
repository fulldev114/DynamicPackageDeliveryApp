//
//  ABCDataParcel.h
//  your-dpd
//
//  Created by Richard Simkins on 07/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ABCDataBase.h"

@interface ABCDataParcel : ABCDataBase
	@property (nonatomic) NSString* collectorName;
	@property (nonatomic) NSString* depotAddress;
	@property (nonatomic) NSString* dispatcherName;
	@property (nonatomic) NSString* driverName;
	@property (nonatomic) NSString* imgurUrl;
	@property (nonatomic) NSString* referenceNumber;
	@property (nonatomic) NSString* status;
	@property (nonatomic) NSString* timeDeliveryComplete;
	@property (nonatomic) NSString* timeDeliveryEstimate;
	@property (nonatomic) NSString* timeDeliveryFromTime;
	@property (nonatomic) NSString* timeDeliveryOnDay;

	- (instancetype) initWithNSDictionary:(NSDictionary*)dictionary;
@end