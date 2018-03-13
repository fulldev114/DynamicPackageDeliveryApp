//
//  ABCDeliveryToDepotDirectionCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCTableViewBase.h"

#import "ABCDataDirection.h"

@interface ABCDeliveryToDepotDirectionCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	- (instancetype)
		initWithDataAddressUserCollection:(NSArray*)dataAddressUserCollection
		andDataAddressDepotCollection:(NSArray*)dataAddressDepotCollection
		andDataDirectionCollection:(NSArray*)dataDirectionCollection;
@end
