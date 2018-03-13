//
//  ABCDeliverDateDetailCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCTableViewBase.h"

#import "ABCDataShop.h"

@interface ABCDeliverDateDetailCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	- (instancetype) initWithDataDateCollection:(NSArray*)dataDateCollection;
@end
