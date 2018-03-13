//
//  ABCDeliverNeighbourAddressCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCTableViewBase.h"

#import "ABCDataShop.h"

@interface ABCDeliverNeighbourAddressCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	- (instancetype) initWithDataAddressCollection:(NSArray*)dataAddressCollection;
@end
