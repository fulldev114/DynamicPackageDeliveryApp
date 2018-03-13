//
//  ABCOptionExpand.m
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCOptionExpand.h"

#import "AppDelegate.h"

@interface ABCOptionExpand()
	@property (nonatomic, strong) BlockExpandState block;
	@property (nonatomic) UIImageView* iconMinus;
	@property (nonatomic) UIImageView* iconPlus;
	@property (nonatomic) NSString* text;
@end

@implementation ABCOptionExpand
	+ (CGFloat) Delay {
		return 0.3f;
	}

	- (CGFloat) SizeLabelPadding {
		return 14.0f;
	}

	- (instancetype)
		initWithText:(NSString*)text
		andBlock:(BlockExpandState)block {

		self = [super init];

		if (!self) return nil;

		[self setBlock:block];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			52.0f)];
		[self setText:text];
		[self initialise];
		[self setExpandState:NO];

		return self;
	}

	- (void) initialise {
		[self setBackgroundColor:[AppDelegate ColourAppBlackLight]];

		[self setIconMinus:[[UIImageView alloc] initWithFrame:CGRectMake(
			[self sizeView].width - [AppDelegate SizeIcon25],
			([self sizeView].height - [AppDelegate SizeIcon25]) / 2.0f,
			[AppDelegate SizeIcon25],
			[AppDelegate SizeIcon25])]];
		[self addSubview:[self iconMinus]];
		[[self iconMinus] setContentMode:UIViewContentModeScaleAspectFill];
		[[self iconMinus] setImage:[UIImage imageNamed:@"option-expand-minus.png"]];

		[self setIconPlus:[[UIImageView alloc] initWithFrame:CGRectMake(
			[self sizeView].width - [AppDelegate SizeIcon25],
			([self sizeView].height - [AppDelegate SizeIcon25]) / 2.0f,
			[AppDelegate SizeIcon25],
			[AppDelegate SizeIcon25])]];
		[self addSubview:[self iconPlus]];
		[[self iconPlus] setContentMode:UIViewContentModeScaleAspectFill];
		[[self iconPlus] setImage:[UIImage imageNamed:@"option-expand-plus.png"]];

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:1];
		[label setText:[self text]];
		[label setTextColor:[UIColor whiteColor]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self sizeView].width - ([self SizeLabelPadding] * 2.0f) - [AppDelegate SizeIcon25],
			[self sizeView].height)];
		[label setFrame:CGRectMake(
			[self SizeLabelPadding],
			([self sizeView].height - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];

		UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
		[self addSubview:button];
		[button
			addTarget:self
			action:@selector(tap)
			forControlEvents:UIControlEventTouchUpInside];
		[button setFrame:CGRectMake(
			0.0f,
			0.0f,
			[self sizeView].width,
			[self sizeView].height)];
	}

	- (void) setExpandState:(BOOL)expand {
		if (expand) {
			[[self iconMinus] setHidden:NO];
			[[self iconPlus] setHidden:YES];
		} else {
			[[self iconMinus] setHidden:YES];
			[[self iconPlus] setHidden:NO];
		}
	}

	- (void) tap {
		[self block]([[self iconPlus] isHidden]);
	}
@end
