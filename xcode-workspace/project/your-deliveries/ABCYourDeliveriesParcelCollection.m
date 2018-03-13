//
//  ABCYourDeliveriesParcelCollection.m
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCYourDeliveriesParcelCollection.h"

#import "ABCYourDeliveriesParcel.h"
#import "ABCYourDeliveriesSection.h"
#import "AppDelegate.h"

@interface ABCYourDeliveriesParcelCollection()
	@property (nonatomic, strong) BlockRowSelect blockActiveRowSelect;
	@property (nonatomic, strong) BlockRowSelect blockPreviousRowSelect;
	@property (nonatomic) NSArray* parcelActiveCollection;
	@property (nonatomic) NSArray* parcelPreviousCollection;
@end

@implementation ABCYourDeliveriesParcelCollection
	- (CGFloat) SizeTableViewSectionFooterHeight {
		return 22.0f;
	}

	- (CGFloat) SizeRowHeight {
		return 70.0f;
	}

	- (CGFloat) SizeSectionHeight {
		return 38.0f;
	}

	- (instancetype)
		initWithActiveDeliveries:(NSArray*)parcelActiveCollection
		andPreviousDeliveries:(NSArray*)parcelPreviousCollection
		andBlockActiveRowSelect:(BlockRowSelect)blockActiveRowSelect
		andBlockPreviousRowSelect:(BlockRowSelect)blockPreviousRowSelect {

		self = [super
			initWithFrame:CGRectZero
			style:UITableViewStyleGrouped];

		if (!self) return nil;

		[self setBlockActiveRowSelect:blockActiveRowSelect];
		[self setBlockPreviousRowSelect:blockPreviousRowSelect];
		[self setParcelActiveCollection:parcelActiveCollection];
		[self setParcelPreviousCollection:parcelPreviousCollection];

		CGFloat sizeViewHeight = [self SizeSectionHeight] * [ABCYourDeliveriesSection Total];
		sizeViewHeight += [self SizeTableViewSectionFooterHeight];
		sizeViewHeight += [self SizeRowHeight] * ([[self parcelActiveCollection] count] + [[self parcelPreviousCollection] count]);

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

	- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView {
		return [ABCYourDeliveriesSection Total];
	}

	- (UITableViewCell*)
		tableView:(UITableView*)tableView
		cellForRowAtIndexPath:(NSIndexPath*)indexPath {
		UIView* view = [[ABCYourDeliveriesParcel alloc]
			initWithDataParcel:[self dataParcelWithIndexPath:indexPath]
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

		return [self SizeTableViewSectionFooterHeight];
	}

	- (CGFloat)
		tableView:(UITableView*)tableView
		heightForHeaderInSection:(NSInteger)section {

		return [self SizeSectionHeight];
	}

	- (NSInteger)
		tableView:(UITableView*)tableView
		numberOfRowsInSection:(NSInteger)section {

		NSInteger count;

		if (section == 0) {
			count = [[self parcelActiveCollection] count];
		} else {
			count = [[self parcelPreviousCollection] count];
		}

		return count;
	}

	- (UIView*)
		tableView:(UITableView*)tableView
		viewForHeaderInSection:(NSInteger)section {

		NSInteger count = [self
			tableView:tableView
			numberOfRowsInSection:section];

		return [[ABCYourDeliveriesSection alloc]
			initWithIndex:section
			andCount:count
			andSizeView:CGSizeMake(
				[self sizeView].width,
				[self SizeSectionHeight])];
	}

	- (NSIndexPath*)
		tableView:(UITableView*)tableView
		willSelectRowAtIndexPath:(NSIndexPath*)indexPath {

		if ([indexPath section] == 0) {
			[self blockActiveRowSelect]([self dataParcelWithIndexPath:indexPath]);
		} else {
			[self blockPreviousRowSelect]([self dataParcelWithIndexPath:indexPath]);
		}

		return nil;
	}

	- (ABCDataParcel*) dataParcelWithIndexPath:(NSIndexPath*)indexPath {
		ABCDataParcel* dataParcel;

		if ([indexPath section] == 0) {
			dataParcel = [[self parcelActiveCollection] objectAtIndex:[indexPath row]];
		} else {
			dataParcel = [[self parcelPreviousCollection] objectAtIndex:[indexPath row]];
		}

		return dataParcel;
	}
@end
