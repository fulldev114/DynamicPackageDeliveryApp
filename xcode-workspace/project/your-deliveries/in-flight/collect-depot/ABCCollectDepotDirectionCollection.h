//
//  ABCCollectDepotDirectionCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCTableViewBase.h"

#import "ABCDataDirection.h"

@interface ABCCollectDepotDirectionCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	- (instancetype) initWithDataDirectionCollection:(NSArray*)dataDirectionCollection;
@end
