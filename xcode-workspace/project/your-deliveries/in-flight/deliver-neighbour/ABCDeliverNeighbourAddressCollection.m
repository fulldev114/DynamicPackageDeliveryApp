//
//  ABCDeliverNeighbourAddressCollection.m
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCDeliverNeighbourAddressCollection.h"

#import "ABCDeliverNeighbourAddress.h"
#import "AppDelegate.h"

@interface ABCDeliverNeighbourAddressCollection()
	@property (nonatomic) NSUInteger radioSelectIndex;
	@property (nonatomic) NSArray* dataAddressCollection;
@end

@implementation ABCDeliverNeighbourAddressCollection
	- (CGFloat) SizeHeadingHeight {
		return 52.0f;
	}

	- (CGFloat) SizeRowHeight {
		return 42.0f;
	}

	- (instancetype) initWithDataAddressCollection:(NSArray*)dataAddressCollection {
		self = [super
			initWithFrame:CGRectZero
			style:UITableViewStyleGrouped];

		if (!self) return nil;

		[self setDataAddressCollection:dataAddressCollection];
		[self setRadioSelectIndex:0];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			[self SizeHeadingHeight] + ([self SizeRowHeight] * [[self dataAddressCollection] count]))];

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

		ABCDeliverNeighbourAddress* view = [[ABCDeliverNeighbourAddress alloc]
			initWithDataAddress:[[self dataAddressCollection] objectAtIndex:[indexPath row]]
			andSizeView:CGSizeMake(
				[self sizeView].width,
				[self SizeRowHeight])];
		[[view radio] setSelected:NO];

		if ([self radioSelectIndex] == [indexPath row]) {
			[[view radio] setSelected:YES];
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
		heightForHeaderInSection:(NSInteger)section {

		return [self SizeHeadingHeight];
	}

	- (NSInteger)
		tableView:(UITableView*)tableView
		numberOfRowsInSection:(NSInteger)section {

		return [[self dataAddressCollection] count];
	}

	-(UIView*)
		tableView:(UITableView*)tableView
		viewForHeaderInSection:(NSInteger)section {

		UIView* view = [[UIView alloc] init];
		[view setBackgroundColor:[UIColor whiteColor]];

		UILabel* label = [[UILabel alloc] init];
		[view addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:1];
		[label setText:NSLocalizedString(@"Select neighbour to deliver to", nil)];
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

	- (NSIndexPath*)
		tableView:(UITableView*)tableView
		willSelectRowAtIndexPath:(NSIndexPath*)indexPath {

		[self setRadioSelectIndex:[indexPath row]];
		[self reloadData];

		return nil;
	}
@end
