//
//  ABCBasicAddressTypeCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 12/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCTableViewBase.h"

@interface ABCBasicAddressTypeCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	typedef void (^BlockBasicAddressTypeCollectionOther)();

	- (instancetype)
		initWithDataCollection:(NSArray*)dataCollection
		andBlockOther:(BlockBasicAddressTypeCollectionOther)blockOther;
	- (BOOL) otherSelected;
@end
