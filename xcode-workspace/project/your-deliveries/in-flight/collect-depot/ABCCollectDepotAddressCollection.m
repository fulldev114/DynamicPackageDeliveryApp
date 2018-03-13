//
//  ABCCollectDepotAddressCollection.m
//  your-dpd
//
//  Created by Richard Simkins on 27/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCCollectDepotAddressCollection.h"

#import "ABCCollectDepotAddressDepot.h"
#import "ABCCollectDepotAddressUser.h"
#import "AppDelegate.h"

@interface ABCCollectDepotAddressCollection()
	@property (nonatomic) NSArray* addressDepotCollection;
	@property (nonatomic) NSArray* addressUserCollection;
@end

@implementation ABCCollectDepotAddressCollection
	- (CGFloat) SizeRowHeight {
		return 65.0f;
	}

	- (instancetype)
		initWithAddressUserCollection:(NSArray*)addressUserCollection
		andAddressDepotCollection:(NSArray*)addressDepotCollection {

		self = [super
			initWithFrame:CGRectZero
			style:UITableViewStyleGrouped];

		if (!self) return nil;

		[self setAddressDepotCollection:addressDepotCollection];
		[self setAddressUserCollection:addressUserCollection];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			[self SizeRowHeight] * ([[self addressDepotCollection] count] + [[self addressUserCollection] count]))];

		[self setAllowsSelection:NO];
		[self setBackgroundColor:[UIColor clearColor]];
		[self setDataSource:self];
		[self setDelegate:self];
		[self setScrollEnabled:NO];
		[self setSeparatorStyle:UITableViewCellSeparatorStyleNone];

		return self;
	}

	- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView {
		return 2;
	}

	- (UITableViewCell*)
		tableView:(UITableView*)tableView
		cellForRowAtIndexPath:(NSIndexPath*)indexPath {

		UIView* view;

		if ([indexPath section] == 0) {
			view = [[ABCCollectDepotAddressUser alloc]
				initWithDataAddress:[[self addressUserCollection] objectAtIndex:[indexPath row]]
				andSizeView:CGSizeMake(
					[self sizeView].width,
					[self SizeRowHeight])];
		} else {
			view = [[ABCCollectDepotAddressDepot alloc]
				initWithDataAddress:[[self addressDepotCollection] objectAtIndex:[indexPath row]]
				andSizeView:CGSizeMake(
					[self sizeView].width,
					[self SizeRowHeight])];
		}

		UITableViewCell* cell = [[UITableViewCell alloc]
			initWithStyle:UITableViewCellStyleDefault
			reuseIdentifier:nil];
		[cell addSubview:view];

		return cell;
	}

	- (CGFloat)
		tableView:(UITableView*)tableView
		heightForRowAtIndexPath:(NSIndexPath*)indexPath {

		return [self SizeRowHeight];
	}

	- (CGFloat)
		tableView:(UITableView*)tableView
		heightForFooterInSection:(NSInteger)section {

		return 0.01f;
	}

	- (CGFloat)
		tableView:(UITableView*)tableView
		heightForHeaderInSection:(NSInteger)section {

		return 0.01f;
	}

	- (NSInteger)
		tableView:(UITableView*)tableView
		numberOfRowsInSection:(NSInteger)section {

		if (section == 0) {
			return [[self addressUserCollection] count];
		} else {
			return [[self addressDepotCollection] count];
		}
	}
@end
