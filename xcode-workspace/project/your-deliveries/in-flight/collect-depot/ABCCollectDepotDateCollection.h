//
//  ABCCollectDepotDateCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 27/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCTableViewBase.h"

@interface ABCCollectDepotDateCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	- (instancetype) initWithDataDateCollection:(NSArray*)dataDateCollection;
@end
