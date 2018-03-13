//
//  ABCYourDeliveriesParcelCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCTableViewBase.h"

#import "ABCDataParcel.h"

@interface ABCYourDeliveriesParcelCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	typedef void (^BlockRowSelect)(ABCDataParcel* dataParcel);

	- (instancetype)
		initWithActiveDeliveries:(NSArray*)parcelActiveCollection
		andPreviousDeliveries:(NSArray*)parcelPreviousCollection
		andBlockActiveRowSelect:(BlockRowSelect)blockActiveRowSelect
		andBlockPreviousRowSelect:(BlockRowSelect)blockPreviousRowSelect;
@end
