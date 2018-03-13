//
//  ABCSettingsAddressCollection.m
//  your-dpd
//
//  Created by Richard Simkins on 01/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCSettingsAddressCollection.h"


#import "ABCSettingsAddress.h"
#import "ABCSettingsSection.h"
#import "AppDelegate.h"

@interface ABCSettingsAddressCollection()
	@property (nonatomic, strong) BlockSettingsAddressCollection blockRowSelect;
	@property (nonatomic) NSArray* dataAddressCollection;
@end

@implementation ABCSettingsAddressCollection
	- (CGFloat) SizeRowHeight {
		return 43.0f;
	}

	- (instancetype)
		initWithDataAddressCollection:(NSArray*)dataAddressCollection
		andBlockRowSelect:(BlockSettingsAddressCollection)blockRowSelect {

		self = [super
			initWithFrame:CGRectZero
			style:UITableViewStyleGrouped];

		if (!self) return nil;

		[self setBlockRowSelect:blockRowSelect];
		[self setDataAddressCollection:dataAddressCollection];

		CGFloat sizeViewHeight = [self SizeRowHeight] * [[self dataAddressCollection] count];

		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			sizeViewHeight)];

		[self setBackgroundColor:[UIColor clearColor]];
		[self setDataSource:self];
		[self setDelegate:self];
		[self setScrollEnabled:NO];
		[self setSeparatorStyle:UITableViewCellSeparatorStyleNone];

		return self;
	}

	- (UITableViewCell*)
		tableView:(UITableView*)tableView
		cellForRowAtIndexPath:(NSIndexPath*)indexPath {

		UIView* view = [[ABCSettingsAddress alloc]
			initWithDataAddress:[[self dataAddressCollection] objectAtIndex:[indexPath row]]
			andSizeView:CGSizeMake(
				[self sizeView].width,
				[self SizeRowHeight])];

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

		return [[self dataAddressCollection] count];
	}

	- (NSIndexPath*)
		tableView:(UITableView*)tableView
		willSelectRowAtIndexPath:(NSIndexPath*)indexPath {

		[self blockRowSelect]([[self dataAddressCollection] objectAtIndex:[indexPath row]]);

		return nil;
	}
@end
