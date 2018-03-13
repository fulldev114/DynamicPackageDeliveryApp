//
//  ABCOptionDrillDown.m
//  your-dpd
//
//  Created by Richard Simkins on 12/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCOptionDrillDown.h"

#import "AppDelegate.h"

@interface ABCOptionDrillDown()
	@property (nonatomic, strong) BlockDrillDown block;
	@property (nonatomic) NSString* text;
@end

@implementation ABCOptionDrillDown
	- (UIFont*) Font {
		return [UIFont systemFontOfSize:12.0f];
	}

	- (CGFloat) SizeLabelPadding {
		return 14.0f;
	}

	- (instancetype)
		initWithText:(NSString*)text
		andBlock:(BlockDrillDown)block {

		self = [super init];

		if (!self) return nil;

		[self setBlock:block];
		[self setExpanded:NO];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			45.0f)];
		[self setText:text];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setBackgroundColor:[UIColor whiteColor]];

		UIImageView* arrow = [[UIImageView alloc] initWithFrame:CGRectMake(
			[self sizeView].width - [AppDelegate SizeIcon25],
			([self sizeView].height - [AppDelegate SizeIcon25]) / 2.0f,
			[AppDelegate SizeIcon25],
			[AppDelegate SizeIcon25])];
		[self addSubview:arrow];
		[arrow setContentMode:UIViewContentModeScaleAspectFill];
		[arrow setImage:[UIImage imageNamed:@"option-arrow.png"]];

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[self Font]];
		[label setNumberOfLines:1];
		[label setText:[self text]];
		[label setTextColor:[AppDelegate ColourAppBlack]];

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

	- (CGFloat) positionWithTop:(CGFloat)top {
		[self
			setPositionX:0.0f
			andPositionY:top];
		top += [AppDelegate SizeSeparationThickness];
		top += [self sizeView].height;

		return top;
	}

	- (void) tap {
		[self block]();
	}
@end
