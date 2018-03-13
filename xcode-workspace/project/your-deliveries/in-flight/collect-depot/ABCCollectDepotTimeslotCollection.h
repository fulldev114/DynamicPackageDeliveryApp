//
//  ABCCollectDepotTimeslotCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 27/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCTableViewBase.h"

#import "ABCDataShop.h"

@interface ABCCollectDepotTimeslotCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	- (instancetype) initWithDataTimeslotCollection:(NSArray*)dataTimeslotCollection;
@end
