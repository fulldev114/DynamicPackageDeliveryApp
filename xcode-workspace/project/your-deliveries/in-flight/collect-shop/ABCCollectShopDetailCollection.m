//
//  ABCCollectShopDetailCollection.m
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCCollectShopDetailCollection.h"

#import "ABCCollectShopDetail.h"
#import "AppDelegate.h"

@interface ABCCollectShopDetailCollection()
	@property (nonatomic) NSArray* dataShopCollection;
	@property (nonatomic) NSUInteger radioSelectIndex;
@end

@implementation ABCCollectShopDetailCollection
	- (CGFloat) SizeHeadingHeight {
		return 52.0f;
	}

	- (CGFloat) SizeRowHeight {
		return 128.0f;
	}

	- (instancetype) initWithDataShopCollection:(NSArray*)dataShopCollection {
		self = [super
			initWithFrame:CGRectZero
			style:UITableViewStyleGrouped];

		if (!self) return nil;

		[self setDataShopCollection:dataShopCollection];
		[self setRadioSelectIndex:0];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			[self SizeHeadingHeight] + ([self SizeRowHeight] * [[self dataShopCollection] count]))];

		[self setAllowsSelection:NO];
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

		ABCCollectShopDetail* view = [[ABCCollectShopDetail alloc]
			initWithDataShop:[[self dataShopCollection] objectAtIndex:[indexPath row]]
			andIndex:[indexPath row] + 1
			andSizeView:CGSizeMake(
				[self sizeView].width,
				[self SizeRowHeight])
			andBlockShopSelect:^(ABCDataShop* dataShop) {
				[self setRadioSelectIndex:[indexPath row]];
				[self reloadData];
				NSLog(@"Shop select.");
			}
			andBlockShopTimes:^(ABCDataShop* dataShop) {
				NSLog(@"Shop openning times.");
			}];
		// # Needed so that touch events fire within the view.
		[view setFrame:CGRectMake(
			0.0f,
			0.0f,
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

		return [[self dataShopCollection] count];
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
		[label setText:NSLocalizedString(@"Select your preferred local collection shop", nil)];
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
