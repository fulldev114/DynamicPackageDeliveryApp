//
//  ABCDeliverSafePlaceSelectCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 22/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCTableViewBase.h"

#import "ABCDataShop.h"

@interface ABCDeliverSafePlaceSelectCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	- (instancetype) initWithSelectCollection:(NSArray*)selectCollection;
@end
