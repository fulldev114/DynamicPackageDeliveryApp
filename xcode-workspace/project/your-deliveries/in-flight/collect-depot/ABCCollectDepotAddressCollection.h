//
//  ABCCollectDepotAddressCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 27/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCTableViewBase.h"

@interface ABCCollectDepotAddressCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	- (instancetype)
		initWithAddressUserCollection:(NSArray*)addressUserCollection
		andAddressDepotCollection:(NSArray*)addressDepotCollection;
@end
