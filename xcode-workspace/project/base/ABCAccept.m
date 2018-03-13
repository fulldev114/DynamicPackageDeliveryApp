//
//  ABCAccept.m
//  your-dpd
//
//  Created by Richard Simkins on 26/05/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCAccept.h"

#import "AppDelegate.h"

@interface ABCAccept()
	@property (nonatomic, strong) BlockAccept blockAccept;
	@property (nonatomic) UIImageView* checkOff;
	@property (nonatomic) UIImageView* checkOn;
	@property (nonatomic) NSString* title;
@end

@implementation ABCAccept
	- (CGFloat) SizePaddingLeft {
		return 28.0f;
	}

	- (instancetype)
		initWithTitle:(NSString*)title
		andBlockAccept:(BlockAccept)blockAccept {

		self = [super init];

		if (!self) return nil;

		[self setBlockAccept:blockAccept];
		[self setTitle:title];
		[self initialise];
		[self setSelected:NO];

		return self;
	}

	- (void) initialise {
		CGFloat width = [[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f);

		[self setCheckOff:[[UIImageView alloc] init]];
		[self addSubview:[self checkOff]];
		[[self checkOff] setContentMode:UIViewContentModeScaleAspectFit];
		[[self checkOff] setFrame:CGRectMake(
			0.0f,
			0.0f,
			[AppDelegate SizeIcon18],
			[AppDelegate SizeIcon18])];
		[[self checkOff] setImage:[UIImage imageNamed:@"accept-check-off.png"]];

		[self setCheckOn:[[UIImageView alloc] init]];
		[self addSubview:[self checkOn]];
		[[self checkOn] setContentMode:UIViewContentModeScaleAspectFit];
		[[self checkOn] setFrame:CGRectMake(
			0.0f,
			0.0f,
			[AppDelegate SizeIcon18],
			[AppDelegate SizeIcon18])];
		[[self checkOn] setImage:[UIImage imageNamed:@"accept-check-on.png"]];

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setFont:[AppDelegate FontRegularWithSize:12.0f]];
		[label setNumberOfLines:0];
		[label setText:[self title]];
		[label setTextColor:[AppDelegate ColourAppBlack]];

		CGSize labelSize = [label sizeThatFits:CGSizeMake(
			width - [self SizePaddingLeft],
			[[UIScreen mainScreen] bounds].size.height)];

		[label setFrame:CGRectMake(
			[self SizePaddingLeft],
			0.0f,
			labelSize.width,
			labelSize.height)];

		[self setSizeView:CGSizeMake(
			width,
			labelSize.height > [AppDelegate SizeIcon18]
				? labelSize.height
				: [AppDelegate SizeIcon18])];

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

	- (void) setSelected:(BOOL)selected {
		[[self checkOff] setHidden:selected];
		[[self checkOn] setHidden:!selected];
	}

	- (void) tap {
		[self setSelected:[[self checkOn] isHidden]];
		[self blockAccept]();
	}
@end
