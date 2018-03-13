//
//  ABCSettingsAddressCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 01/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCTableViewBase.h"

#import "ABCDataAddress.h"

@interface ABCSettingsAddressCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	typedef void (^BlockSettingsAddressCollection)(ABCDataAddress* dataAddress);

	- (instancetype)
		initWithDataAddressCollection:(NSArray*)dataAddressCollection
		andBlockRowSelect:(BlockSettingsAddressCollection)blockRowSelect;
@end
