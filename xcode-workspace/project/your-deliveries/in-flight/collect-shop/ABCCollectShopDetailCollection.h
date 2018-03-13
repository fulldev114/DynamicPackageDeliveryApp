//
//  ABCCollectShopDetailCollection.h
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ABCDataShop.h"
#import "ABCTableViewBase.h"

@interface ABCCollectShopDetailCollection : ABCTableViewBase<UITableViewDataSource, UITableViewDelegate>
	- (instancetype) initWithDataShopCollection:(NSArray*)dataShopCollection;
@end
