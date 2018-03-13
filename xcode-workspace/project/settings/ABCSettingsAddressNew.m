//
//  ABCSettingsAddressNew.m
//  your-dpd
//
//  Created by Richard Simkins on 02/06/2015.
//  Copyright (c) 2015 dpd. All rights reserved.
//

#import "ABCSettingsAddressNew.h"

#import "AppDelegate.h"

@interface ABCSettingsAddressNew()
	@property (nonatomic, strong) BlockSettingsAddressNew block;
@end

@implementation ABCSettingsAddressNew
	- (CGFloat) SizePaddingLeft {
		return [AppDelegate SizePaddingFromSides];
	}

	- (CGFloat) SizePaddingRight {
		return [AppDelegate SizeIcon25];
	}

	- (instancetype) initWithBlock:(BlockSettingsAddressNew)block {
		self = [super init];

		if (!self) return nil;

		[self setBlock:block];
		[self setSizeView:CGSizeMake(
			[[UIScreen mainScreen] bounds].size.width - ([AppDelegate SizePaddingFromSides] * 2.0f),
			44.0f)];
		[self initialise];

		return self;
	}

	- (void) initialise {
		[self setBackgroundColor:[UIColor whiteColor]];

		CGSize sizeThatFits = CGSizeMake(
			[self sizeView].width - [self SizePaddingLeft] - [self SizePaddingRight],
			[self sizeView].height - ([AppDelegate SizePaddingFromSidesThin] * 2.0f));

		UIView* horizontalLine = [[UIView alloc] initWithFrame:CGRectMake(
			0.0f,
			0.0f,
			[self sizeView].width,
			[AppDelegate SizeSeparationThickness])];
		[self addSubview:horizontalLine];
		[horizontalLine setBackgroundColor:[AppDelegate ColourAppGreyLight]];

		NSAttributedString* labelText = [[NSAttributedString alloc]
			initWithString:NSLocalizedString(@"Add new address", nil)
			attributes:@{
				NSFontAttributeName:[AppDelegate FontRegularWithSize:12.0f],
				NSForegroundColorAttributeName:[AppDelegate ColourAppBlack],
			}];

		UILabel* label = [[UILabel alloc] init];
		[self addSubview:label];
		[label setAttributedText:labelText];

		CGSize labelSize = [label sizeThatFits:sizeThatFits];

		[label setFrame:CGRectMake(
			[self SizePaddingLeft],
			([self sizeView].height - labelSize.height) / 2.0f,
			labelSize.width,
			labelSize.height)];

		UIImageView* arrow = [[UIImageView alloc] initWithFrame:CGRectMake(
			[self sizeView].width - [AppDelegate SizeIcon25],
			([self sizeView].height - [AppDelegate SizeIcon25]) / 2.0f,
			[AppDelegate SizeIcon25],
			[AppDelegate SizeIcon25])];
		[self addSubview:arrow];
		[arrow setContentMode:UIViewContentModeScaleAspectFill];
		[arrow setImage:[UIImage imageNamed:@"settings-new.png"]];

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

	- (void) tap {
		[self block]();
	}
@end
