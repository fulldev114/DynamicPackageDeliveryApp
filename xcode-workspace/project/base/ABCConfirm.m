//
//  ABCConfirm.m
//  your-dpd
//
//  Created by Richard Simkins on 13/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCConfirm.h"

#import "AppDelegate.h"

@interface ABCConfirm()
	@property (nonatomic, strong) BlockConfirm block;
	@property (nonatomic) NSString* text;
@end

@implementation ABCConfirm
	- (CGFloat) SizePaddingHorizontal {
		return 19.0f;
	}

	- (CGFloat) SizeViewHeight {
		CGFloat height = [self SizeButtonHeight];
		height += [AppDelegate SizeSeparationThickness] * 2.0f;
		height += [self SizePaddingHorizontal] * 2.0f;

		return height;
	}

	- (CGFloat) SizeButtonHeight {
		return 45.0f;
	}

	- (CGFloat) SizeViewWidth {
		return [[UIScreen mainScreen] bounds].size.width;
	}

	- (instancetype)
		initWithText:(NSString*)text
		andBlock:(BlockConfirm)block {

		self = [super init];

		if (!self) return nil;

		[self setBlock:block];
		[self setText:text];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setBackgroundColor:[AppDelegate ColourAppRed]];

		UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
		[self addSubview:button];
		[[button layer] setBorderColor:[[UIColor whiteColor] CGColor]];
		[[button layer] setBorderWidth:[AppDelegate SizeSeparationThickness]];
		[button
			addTarget:self
			action:@selector(tap)
			forControlEvents:UIControlEventTouchUpInside];
		[button setFrame:CGRectMake(
			[AppDelegate SizePaddingFromSides],
			[self SizePaddingHorizontal] + [AppDelegate SizeSeparationThickness],
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f) - ([AppDelegate SizeSeparationThickness] * 2.0f),
			[self SizeButtonHeight])];
		[button
			setTitle:[self text]
			forState:UIControlStateNormal];
		[[button titleLabel] setFont:[AppDelegate FontRegularWithSize:16.0f]];
	}

	- (void) tap {
		[self block]();
	}
@end
