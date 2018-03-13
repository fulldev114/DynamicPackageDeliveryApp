//
//  ABCPin.m
//  your-dpd
//
//  Created by Richard Simkins on 15/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCPin.h"

#import "AppDelegate.h"

@interface ABCPin()
	@property (nonatomic) CGFloat bottom;
	@property (nonatomic) UIView* circle;
	@property (nonatomic) UIColor* colour;
	@property (nonatomic) NSString* image;
	@property (nonatomic) NSUInteger index;
	@property (nonatomic) CGFloat left;
	@property (nonatomic) CGFloat middle;
	@property (nonatomic) CGFloat right;
	@property (nonatomic) NSString* text;
	@property (nonatomic) CGFloat top;
@end

@implementation ABCPin
	- (CGFloat) SizeCircleDiameter {
		return 25.0f;
	}

	+ (CGFloat) SizeViewHeight {
		return 35.0f;
	}

	+ (CGFloat) SizeViewWidth {
		return 35.0f;
	}

	- (instancetype) init {
		self = [super init];

		if (!self) return nil;

		[self setBackgroundColor:[UIColor clearColor]];
		[self initialise];

		return self;
	}

	- (instancetype) initWithImage:(NSString*)image {
		self = [super init];

		if (!self) return nil;

		[self setBackgroundColor:[UIColor clearColor]];
		[self setImage:image];
		[self initialise];
		[self setupImage];

		return self;
	}

	- (instancetype) initWithIndex:(NSUInteger)index {
		self = [super init];

		if (!self) return nil;

		[self setBackgroundColor:[UIColor clearColor]];
		[self setIndex:index];
		[self initialise];
		[self setupIndex];

		return self;
	}

	- (instancetype) initWithText:(NSString*)text {
		self = [super init];

		if (!self) return nil;

		[self setBackgroundColor:[UIColor clearColor]];
		[self setText:text];
		[self initialise];
		[self setupText];

		return self;
	}

	- (void) drawRect:(CGRect)rect {
		UIBezierPath* path = [[UIBezierPath alloc] init];
		[path moveToPoint:CGPointMake(
			[self middle],
			[self bottom])];
		[path addLineToPoint:CGPointMake(
			[self left],
			[self top])];
		[path addLineToPoint:CGPointMake(
			[self right],
			[self top])];
		[[self colour] setFill];
		[path fill];
	}

	- (void) colourSet:(UIColor*)colour {
		[self setColour:colour];
		[[self circle] setBackgroundColor:[self colour]];
	}

	- (void) initialise {
		[self setCircle:[[UIView alloc] initWithFrame:CGRectMake(
			([ABCPin SizeViewWidth] - [self SizeCircleDiameter]) / 2.0f,
			0.0f,
			[self SizeCircleDiameter],
			[self SizeCircleDiameter])]];
		[self addSubview:[self circle]];
		[[[self circle] layer] setCornerRadius:[self SizeCircleDiameter] / 2.0f];
		[[self circle] setClipsToBounds:YES];

		CGFloat arrowTopSideWidth = ([self SizeCircleDiameter] / 2.0f) * cosf(40.0f * ([AppDelegate Pi] / 180.0f));
		arrowTopSideWidth *= 2.0f;
		CGFloat arrowOverlapHeight = ([self SizeCircleDiameter] / 2.0f) * sinf(40.0f * ([AppDelegate Pi] / 180.0f));
		arrowOverlapHeight = ([self SizeCircleDiameter] / 2.0f) - arrowOverlapHeight;

		[self setLeft:([ABCPin SizeViewWidth] - arrowTopSideWidth) / 2.0f];
		[self setMiddle:[ABCPin SizeViewWidth] / 2.0f];
		[self setRight:[self left] + arrowTopSideWidth];
		[self setTop:[self SizeCircleDiameter] - arrowOverlapHeight];
		[self setBottom:[ABCPin SizeViewHeight]];

		[self colourSet:[AppDelegate ColourAppRed]];
	}

	- (void) setupImage {
		UIImageView* image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[self image]]];
		[self addSubview:image];
		[[image layer] setCornerRadius:[self SizeCircleDiameter] / 2.0f];
		[image setClipsToBounds:YES];
		[image setContentMode:UIViewContentModeScaleAspectFit];
		[image setFrame:CGRectMake(
			([ABCPin SizeViewWidth] - [self SizeCircleDiameter]) / 2.0f,
			0.0f,
			[self SizeCircleDiameter],
			[self SizeCircleDiameter])];
	}

	- (void) setupIndex {
		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:16.0f]];
		[label setNumberOfLines:1];
		[label setText:[NSString stringWithFormat:@"%lu", (unsigned long)[self index]]];
		[label setTextColor:[UIColor whiteColor]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self SizeCircleDiameter],
			[self SizeCircleDiameter])];

		[label setFrame:CGRectMake(
			([ABCPin SizeViewWidth] - labelSize.width) / 2.0f,
			([self SizeCircleDiameter] - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];
	}

	- (void) setupText {
		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:16.0f]];
		[label setNumberOfLines:1];
		[label setText:[NSString stringWithFormat:@"%@", [self text]]];
		[label setTextColor:[UIColor whiteColor]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			[self SizeCircleDiameter],
			[self SizeCircleDiameter])];

		[label setFrame:CGRectMake(
			([ABCPin SizeViewWidth] - labelSize.width) / 2.0f,
			([self SizeCircleDiameter] - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];
	}
@end
