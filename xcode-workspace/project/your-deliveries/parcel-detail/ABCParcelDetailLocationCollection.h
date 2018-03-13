//
//  ABCParcelDetailLocationCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCDataParcelLocation.h"
#import "ABCTableViewBase.h"

@interface ABCParcelDetailLocationCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	- (instancetype) initWithDataParcelLocationCollection:(NSArray*)dataParcelLocationCollection;
@end
