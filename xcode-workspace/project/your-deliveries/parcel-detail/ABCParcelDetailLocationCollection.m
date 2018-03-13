//
//  ABCParcelDetailLocationCollection.m
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCParcelDetailLocationCollection.h"

#import "AppDelegate.h"

#import "ABCParcelDetailLocation.h"

@interface ABCParcelDetailLocationCollection()
	@property (nonatomic) NSArray* dataParcelLocationCollection;
//	@property (nonatomic) UITableView* tableView;
@end

@implementation ABCParcelDetailLocationCollection
	- (CGFloat) SizeHeadingHeight {
		return 32.0f;
	}

	- (CGFloat) SizeRowHeight {
		return 50.0f;
	}

/*	- (CGFloat) SizeTableViewHeight {
		CGFloat height = [self SizeRowHeight] * [[self dataParcelLocationCollection] count];
		height += [self SizeHeadingHeight];

		return height;
	}

	- (CGFloat) SizeTableViewWidth {
		return [[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 4.0f);
	}*/

	- (instancetype) initWithDataParcelLocationCollection:(NSArray*)dataParcelLocationCollection {
		self = [super
			initWithFrame:CGRectZero
			style:UITableViewStyleGrouped];

		if (!self) return nil;

		[self setDataParcelLocationCollection:dataParcelLocationCollection];
		[self setExpanded:NO];

		CGFloat height = [self SizeRowHeight] * [[self dataParcelLocationCollection] count];
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
/*		[self setTableView:[[UITableView alloc]
			initWithFrame:CGRectZero
			style:UITableViewStyleGrouped]];
		[self addSubview:[self tableView]];
		[[self tableView] setAllowsSelection:NO];
		[[self tableView] setBackgroundColor:[UIColor clearColor]];
		[[self tableView] setDataSource:self];
		[[self tableView] setDelegate:self];
		[[self tableView] setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSides],
			0.0f,
			[self SizeTableViewWidth],
			[self SizeTableViewHeight])];
		[[self tableView] setScrollEnabled:NO];
		[[self tableView] setSeparatorStyle:UITableViewCellSeparatorStyleNone];

		[self setBackgroundColor:[UIColor whiteColor]];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			[self SizeTableViewHeight] + ([AppDelegate SizePaddingFromSides] * 2.0f))];*/

		return self;
	}

	- (UITableViewCell*)
		tableView:(UITableView*)tableView
		cellForRowAtIndexPath:(NSIndexPath*)indexPath {

		UIView* view = [[ABCParcelDetailLocation alloc]
			initWithDataParcelLocation:[[self dataParcelLocationCollection] objectAtIndex:[indexPath row]]
			andSizeView:CGSizeMake(
				[self sizeView].width,//[self SizeTableViewWidth],
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

		return [[self dataParcelLocationCollection] count];
	}

	- (UIView*)
		tableView:(UITableView*)tableView
		viewForHeaderInSection:(NSInteger)section {

		UIView* view = [[UIView alloc] init];
		UILabel* label;

		label = [self
			headingLabelWithText:@"Date & Time"
			andWidth:[ABCParcelDetailLocation SizeColumnOneWidth]
			andLeft:0.0f];
		[view addSubview:label];

		label = [self
			headingLabelWithText:@"Location"
			andWidth:[ABCParcelDetailLocation SizeColumnTwoWidth]
			andLeft:[ABCParcelDetailLocation SizeColumnOneWidth]];
		[view addSubview:label];

		label = [self
			headingLabelWithText:@"Description"
			andWidth:[self sizeView].width - [ABCParcelDetailLocation SizeColumnOneWidth] - [ABCParcelDetailLocation SizeColumnTwoWidth]//[self SizeTableViewWidth] - [ABCParcelDetailLocation SizeColumnOneWidth] - [ABCParcelDetailLocation SizeColumnTwoWidth]
			andLeft:[ABCParcelDetailLocation SizeColumnOneWidth] + [ABCParcelDetailLocation SizeColumnTwoWidth]];
		[view addSubview:label];

		return view;
	}

	- (UILabel*)
		headingLabelWithText:(NSString*)text
		andWidth:(CGFloat)width
		andLeft:(CGFloat)left {

		UILabel* label = [[UILabel alloc] init];
		[label setFont:[AppDelegate FontRegularWithSize:10.0f]];
		[label setNumberOfLines:2];
		[label setText:text];
		[label setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			width - ([AppDelegate SizePaddingFromSidesThin] * 2.0f),
			[self SizeHeadingHeight])];//[self tableView:[self tableView] heightForHeaderInSection:0])];

		[label setFrame:CGRectMake(
			left + [AppDelegate SizePaddingFromSidesThin],
			([self SizeHeadingHeight] - labelSize.height) / 2.0f,//([self tableView:[self tableView] heightForHeaderInSection:0] - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];

		return label;
	}
@end
