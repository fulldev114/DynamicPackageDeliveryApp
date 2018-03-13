//
//  ABCDeliveryToDepotDirectionCollection.m
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliveryToDepotDirectionCollection.h"

#import "ABCDeliveryToDepotAddressDepot.h"
#import "ABCDeliveryToDepotAddressUser.h"
#import "ABCDeliveryToDepotDirection.h"
#import "AppDelegate.h"

@interface ABCDeliveryToDepotDirectionCollection()
	@property (nonatomic) NSArray* dataAddressDepotCollection;
	@property (nonatomic) NSArray* dataAddressUserCollection;
	@property (nonatomic) NSArray* dataDirectionCollection;
@end

@implementation ABCDeliveryToDepotDirectionCollection
	- (CGFloat) SizeHeadingHeight {
		return 27.0f;
	}

	- (CGFloat) SizeRowHeightAddress {
		return 45.0f;
	}

	- (CGFloat) SizeRowHeightDirection {
		return 40.0f;
	}

	- (instancetype)
		initWithDataAddressUserCollection:(NSArray*)dataAddressUserCollection
		andDataAddressDepotCollection:(NSArray*)dataAddressDepotCollection
		andDataDirectionCollection:(NSArray*)dataDirectionCollection {

		self = [super
			initWithFrame:CGRectZero
			style:UITableViewStyleGrouped];

		if (!self) return nil;

		[self setDataAddressDepotCollection:dataAddressDepotCollection];
		[self setDataAddressUserCollection:dataAddressUserCollection];
		[self setDataDirectionCollection:dataDirectionCollection];
		[self setExpanded:NO];

		CGFloat height = [self SizeRowHeightAddress] * [[self dataAddressDepotCollection] count];
		height += [self SizeRowHeightAddress] * [[self dataAddressUserCollection] count];
		height += [self SizeHeadingHeight];
		height += [self SizeRowHeightDirection] * [[self dataDirectionCollection] count];
		height += [self SizeHeadingHeight];

		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			height)];

		[self setAllowsSelection:NO];
		[self setBackgroundColor:[UIColor whiteColor]];
		[self setDataSource:self];
		[self setDelegate:self];
		[self setScrollEnabled:NO];
		[self setSeparatorStyle:UITableViewCellSeparatorStyleNone];

		return self;
	}

	- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView {
		return 3;
	}

	- (UITableViewCell*)
		tableView:(UITableView*)tableView
		cellForRowAtIndexPath:(NSIndexPath*)indexPath {

		UIView* view;

		if ([indexPath section] == 0) {
			view = [[ABCDeliveryToDepotAddressUser alloc]
				initWithDataAddress:[[self dataAddressUserCollection] objectAtIndex:[indexPath row]]
				andSizeView:CGSizeMake(
					[self sizeView].width,
					[self SizeRowHeightAddress])];
		} else if ([indexPath section] == 1) {
			view = [[ABCDeliveryToDepotAddressDepot alloc]
				initWithDataAddress:[[self dataAddressDepotCollection] objectAtIndex:[indexPath row]]
				andSizeView:CGSizeMake(
					[self sizeView].width,
					[self SizeRowHeightAddress])];
		} else {
			view = [[ABCDeliveryToDepotDirection alloc]
				initWithDataDirection:[[self dataDirectionCollection] objectAtIndex:[indexPath row]]
				andIndex:[indexPath row]
				andSizeView:CGSizeMake(
					[self sizeView].width,
					[self SizeRowHeightDirection])];
		}

		UITableViewCell* cell = [[UITableViewCell alloc]
			initWithStyle:UITableViewCellStyleDefault
			reuseIdentifier:nil];
		[cell addSubview:view];

		return cell;
	}

	- (CGFloat)
		tableView:(UITableView*)tableView
		heightForFooterInSection:(NSInteger)section {

		return 0.01f;
	}

	- (CGFloat)
		tableView:(UITableView*)tableView
		heightForHeaderInSection:(NSInteger)section {

		if (section == 0) {
			return [self SizeHeadingHeight];
		} else if (section == 1) {
			return 0.01f;
		} else {
			return [self SizeHeadingHeight];
		}
	}

	- (CGFloat)
		tableView:(UITableView*)tableView
		heightForRowAtIndexPath:(NSIndexPath*)indexPath {

		if ([indexPath section] == 0) {
			return [self SizeRowHeightAddress];
		} else if ([indexPath section] == 1) {
			return [self SizeRowHeightAddress];
		} else {
			return [self SizeRowHeightDirection];
		}
	}

	- (NSInteger)
		tableView:(UITableView*)tableView
		numberOfRowsInSection:(NSInteger)section {

		if (section == 0) {
			return [[self dataAddressUserCollection] count];
		} else if (section == 1) {
			return [[self dataAddressDepotCollection] count];
		} else {
			return [[self dataDirectionCollection] count];
		}
	}

	- (UIView*)
		tableView:(UITableView*)tableView
		viewForHeaderInSection:(NSInteger)section {

		if (section == 1) return nil;

		UIView* view = [[UIView alloc] init];
		UIView* horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(
			0.0f,
			0.0f,
			[self sizeView].width,
			[AppDelegate SizeSeparationThickness])];
		[view addSubview:horizontalLine];
		[horizontalLine setBackgroundColor:[AppDelegate ColourAppGreyLight]];

		UILabel* label = [[UILabel alloc] init];
		[view addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:10.0f]];
		[label setNumberOfLines:0];

		if (section == 0) {
			[label setText:@"Addresses"];
		} else {
			[label setText:@"4.6mi - about 13mins"];
		}

		[label setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self sizeView].width,
			[self SizeHeadingHeight])];

		[label setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSides],
			([self SizeHeadingHeight] - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];

		return view;
	}
@end
