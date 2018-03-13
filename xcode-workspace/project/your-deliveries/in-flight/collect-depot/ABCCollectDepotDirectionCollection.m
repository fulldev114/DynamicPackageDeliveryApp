//
//  ABCCollectDepotDirectionCollection.m
//  your-dpd
//
//  Created by Richard Simkins on 28/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCCollectDepotDirectionCollection.h"

#import "ABCCollectDepotDirection.h"
#import "AppDelegate.h"

@interface ABCCollectDepotDirectionCollection()
	@property (nonatomic) NSArray* dataDirectionCollection;
@end

@implementation ABCCollectDepotDirectionCollection
	- (CGFloat) SizeHeadingHeight {
		return 27.0f;
	}

	- (CGFloat) SizeRowHeight {
		return 40.0f;
	}

	- (instancetype) initWithDataDirectionCollection:(NSArray*)dataDirectionCollection {
		self = [super
			initWithFrame:CGRectZero
			style:UITableViewStyleGrouped];

		if (!self) return nil;

		[self setDataDirectionCollection:dataDirectionCollection];
		[self setExpanded:NO];

		CGFloat height = [self SizeRowHeight] * [[self dataDirectionCollection] count];
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

	- (UITableViewCell*)
		tableView:(UITableView*)tableView
		cellForRowAtIndexPath:(NSIndexPath*)indexPath {

		UIView* view = [[ABCCollectDepotDirection alloc]
			initWithDataDirection:[[self dataDirectionCollection] objectAtIndex:[indexPath row]]
			andIndex:[indexPath row]
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
		heightForHeaderInSection:(NSInteger)section {

		return [self SizeHeadingHeight];
	}

	- (CGFloat)
		tableView:(UITableView*)tableView
		heightForRowAtIndexPath:(NSIndexPath*)indexPath {

		return [self SizeRowHeight];
	}

	- (NSInteger)
		tableView:(UITableView*)tableView
		numberOfRowsInSection:(NSInteger)section {

		return [[self dataDirectionCollection] count];
	}

	- (UIView*)
		tableView:(UITableView*)tableView
		viewForHeaderInSection:(NSInteger)section {

		UIView* view = [[UIView alloc] init];

		UILabel* label = [[UILabel alloc] init];
		[view addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:10.0f]];
		[label setNumberOfLines:0];
		[label setText:@"4.6mi - about 13mins"];
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
