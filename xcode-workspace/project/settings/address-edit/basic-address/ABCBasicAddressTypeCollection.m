//
//  ABCBasicAddressTypeCollection.m
//  your-dpd
//
//  Created by Richard Simkins on 12/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCBasicAddressTypeCollection.h"

#import "ABCBasicAddressType.h"
#import "AppDelegate.h"

@interface ABCBasicAddressTypeCollection()
	@property (nonatomic, strong) BlockBasicAddressTypeCollectionOther blockOther;
	@property (nonatomic) UIButton* heading;
	@property (nonatomic) NSArray* dataCollection;
	@property (nonatomic) NSUInteger radioSelectIndex;
@end

@implementation ABCBasicAddressTypeCollection
	- (CGFloat) SizeHeadingHeight {
		return 30.0f;
	}

	- (CGFloat) SizeRowHeight {
		return 42.0f;
	}

	- (instancetype)
		initWithDataCollection:(NSArray*)dataCollection
		andBlockOther:(BlockBasicAddressTypeCollectionOther)blockOther {

		self = [super
			initWithFrame:CGRectZero
			style:UITableViewStyleGrouped];

		if (!self) return nil;

		[self setBlockOther:blockOther];
		[self setDataCollection:dataCollection];
		[self setHeading:[UIButton buttonWithType:UIButtonTypeCustom]];
		[[self heading]
			addTarget:self
			action:@selector(tapHeading)
			forControlEvents:UIControlEventTouchUpInside];
		[self setRadioSelectIndex:0];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			[self SizeHeadingHeight] + ([self SizeRowHeight] * [[self dataCollection] count]))];

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

		ABCBasicAddressType* view = [[ABCBasicAddressType alloc]
			initWithData:[[self dataCollection] objectAtIndex:[indexPath row]]
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

		return [[self dataCollection] count];
	}

	-(UIView*)
		tableView:(UITableView*)tableView
		viewForHeaderInSection:(NSInteger)section {

		UIView* view = [[UIView alloc] init];

		UILabel* label = [[UILabel alloc] init];
		[view addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:1];
		[label setText:NSLocalizedString(@"Which address is this?", nil)];
		[label setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self sizeView].width,
			[self SizeHeadingHeight])];

		[label setFrame:CGRectMake(
			0.0f,
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
		[self blockOther]();

		return nil;
	}

	- (BOOL) otherSelected {
		return [self radioSelectIndex] == [[self dataCollection] count] - 1;
	}

	- (CGFloat)
		setPositionX:(CGFloat)x
		andPositionY:(CGFloat)y {

		CGFloat height = [super
			setPositionX:x
			andPositionY:y];

		[[self heading] setFrame:CGRectMake(
			x,
			y,
			[self sizeView].width,
			[self SizeHeadingHeight]
		)];

		return height;
	}

	- (void) tapHeading {
		[self blockOther]();
	}

	- (NSArray*) viewCollectionForScrollViewForeground {
		return @[
			self,
			[self heading],
		];
	}
@end
