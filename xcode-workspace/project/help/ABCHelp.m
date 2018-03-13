//
//  ABCHelp.m
//  your-dpd
//
//  Created by Richard Simkins on 01/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCHelp.h"

#import "AppDelegate.h"

@interface ABCHelp()
	@property (nonatomic) UIScrollView* scrollView;
@end

@implementation ABCHelp
	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		return self;
	}

	- (void) viewDidLoad {
		[super viewDidLoad];

		[self setScrollView:[[UIScrollView alloc] init]];
		[[self view] addSubview:[self scrollView]];
	}

	- (void) updateStatusBarHeightChangesWithDifference:(CGFloat)difference {
		CGFloat top = [AppDelegate SizePaddingFromSides];

		[[self scrollView] setContentSize:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width,
			top)];
		[[self scrollView] setFrame:CGRectMake(
			0.0f,
			0.0f,
			[[UIScreen mainScreen] bounds].size.width,
			[[self view] frame].size.height + difference)];
	}
@end
